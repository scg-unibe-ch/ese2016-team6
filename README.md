ESE Project
----------------------------------
Prerequisites: Java JDK8, MySQL and Maven installed

**Windows Instructions:**
  
Environment Variables to set: JAVA_HOME and C:\..\maven\bin to PATH  
Make sure both 'java -version' and 'mvn -version' work from the commandline  
Set an empty password for the MySQL root user in your MySQL Workbench on the left-handed Navigator: Management > Users and Privileges  
Make sure that you have a MySQL Connection up and running: Navigator > Instance > Startup/Shutdown (if you run into any sql errors later on just stop and restart the server in here)  
Within Powershell or CMD cd to the project root of the cloned repository \..\ese2016-team6\  
\..\ese2016-team6> mvn jetty:stop  
\..\ese2016-team6> mvn jetty:run  


ESE Base Project
----------------------------------
To build this project, please follow these steps:

1. You need to have Java JDK8 installed. JDK7 and JRE8 are *not* enough. Also check that the JDK8 is properly added to the workspace by checking that it is added under *Eclipse preferences -> Java -> Installed JREs*. It should be visible and checked as the default there. Use the latest version of Eclipse or STS.
2. MySQL should installed and accessible as the user *root* with no password.
3. Build the project using `jetty:stop jetty:run`. The build adds test users and test data to the database, so no additional steps should be required.
4. Visit the site at [http://localhost:8080](http://localhost:8080). You can find the test users listed on the login page.


**Credits:**

Thanks to [lucaliechti](https://github.com/lucaliechti), [mariokaufmann](https://github.com/mariokaufmann), [RaphaelBucher](https://github.com/RaphaelBucher), and [tomaszkolonko](https://github.com/tomaszkolonko) for this very good base project. 
