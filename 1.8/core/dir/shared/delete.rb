shared :dir_delete do |cmd|
  describe "Dir.#{cmd}" do
    it "removes empty directories" do
      Dir.mkdir 'empty_subdir'
      Dir.send(cmd, 'empty_subdir').should == 0
    end

    it "raises a SystemCallError when trying to remove a nonempty directory" do
      lambda { Dir.send cmd, 'subdir_one' }.should raise_error(SystemCallError)
    end

    ruby_bug "Ruby bug 238", "1.9" do
      it "raises a SystemCallError if lacking adequate permissions to remove the directory" do
        FileUtils.mkdir_p("noperm_#{cmd}/child")
        File.chmod(0000, "noperm_#{cmd}")

        lambda { Dir.send cmd, "noperm_#{cmd}/child" }.should raise_error(SystemCallError)

        platform_is_not(:windows) do
          File.chmod(0777, "noperm_#{cmd}")
        end
        platform_is(:windows) do
          File.chmod(0666, "noperm_#{cmd}")
        end
        Dir.rmdir "noperm_#{cmd}/child"
        Dir.rmdir "noperm_#{cmd}"
      end
    end
  end
end
