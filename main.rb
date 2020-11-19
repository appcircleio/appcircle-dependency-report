require 'yaml'
require 'open3'
require 'fileutils'
require 'pathname'

def get_env_variable(key)
	return (ENV[key] == nil || ENV[key] == "") ? nil : ENV[key]
end

ac_module = get_env_variable("AC_MODULE") || abort('Missing module.')
ac_repo_path = get_env_variable("AC_REPOSITORY_DIR") || abort('Missing repo path.')
ac_output_folder = get_env_variable("AC_OUTPUT_DIR") || abort('Missing output folder.')
ac_project_path = get_env_variable("AC_PROJECT_PATH") || "."
ac_dependency_configuration = "implementation"

def run_command(command)
    puts "@@[command] #{command}"
    unless system(command)
      exit $?.exitstatus
    end
end

gradlew_folder_path = ""
if Pathname.new("#{ac_project_path}").absolute?
    gradlew_folder_path = ac_project_path
else
    gradlew_folder_path = File.expand_path(File.join(ac_repo_path, ac_project_path))
end

Dir.chdir("#{gradlew_folder_path}")
run_command("chmod +x gradlew")
command = "./gradlew #{ac_module}:dependencies"
dependency_report_path="#{ac_output_folder}/dependencyReport.txt"
if(ac_dependency_configuration != nil) 
    command = "#{command} --configuration #{ac_dependency_configuration}"
end

run_command("#{command} >> #{dependency_report_path}")
puts "Exporting AC_ANDROID_DEPENDENCY_REPORT_PATH=#{dependency_report_path}"

open(ENV['AC_ENV_FILE_PATH'], 'a') { |f|
    f.puts "AC_ANDROID_DEPENDENCY_REPORT_PATH=#{dependency_report_path}"
}

exit 0