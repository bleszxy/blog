# 作用

Liquibase 用来对数据库进行跟踪、部署、版本控制的工具。可以简单这么理解：通过diff命令，对比本地数据库和线上数据库的差异性，按照日期生成sql changelog.xml文件，项目启动时会执行update命令对比changelog.xml执行差异，如有差异，将差异的changelog.xml执行。注意：每个changelog.xml的执行都会在Liquibase默认生成的DATABASECHANGELOG表中记录。



# maven plugin

[http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/plugin-info.html](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/plugin-info.html)

常用的命令为dif和update，dif为寻找差异性，update为执行差异变更。

## Plugin Documentation

Goals available for this plugin:

| Goal                                                         | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [liquibase:changelogSync](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/changelogSync-mojo.html) | Marks all unapplied changes to the database as applied in the change log. |
| [liquibase:changelogSyncSQL](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/changelogSyncSQL-mojo.html) | Generates SQL that marks all unapplied changes as applied.   |
| [liquibase:clearCheckSums](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/clearCheckSums-mojo.html) | Clears all checksums in the current changelog, so they will be recalculated next update. |
| [liquibase:dbDoc](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/dbDoc-mojo.html) | Generates dbDocs against the database.                       |
| [liquibase:diff](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/diff-mojo.html) | Generates a diff between the specified database and the reference database. |
| [liquibase:dropAll](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/dropAll-mojo.html) | Drops all database objects owned by the user. Note that functions, procedures and packages are not dropped. |
| [liquibase:listLocks](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/listLocks-mojo.html) | Lists all Liquibase updater locks on the current database.   |
| [liquibase:migrate](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/migrate-mojo.html) | **Deprecated.** Use the LiquibaseUpdate class or Maven goal "update" instead. |
| [liquibase:migrateSQL](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/migrateSQL-mojo.html) | **Deprecated.** Use `LiquibaseUpdateSQL` or Maven goal "updateSQL" instead. |
| [liquibase:releaseLocks](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/releaseLocks-mojo.html) | Removes any Liquibase updater locks from the current database. |
| [liquibase:rollback](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/rollback-mojo.html) | Invokes Liquibase rollbacks on a database.                   |
| [liquibase:rollbackSQL](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/rollbackSQL-mojo.html) | Generates the SQL that is required to rollback the database to the specified pointing attributes 'rollbackCount', 'rollbackTag' |
| [liquibase:status](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/status-mojo.html) | Prints which changesets need to be applied to the database.  |
| [liquibase:tag](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/tag-mojo.html) | Writes a Liquibase tag to the database.                      |
| [liquibase:update](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/update-mojo.html) | Applies the DatabaseChangeLogs to the database. Useful as part of the build process. |
| [liquibase:updateSQL](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/updateSQL-mojo.html) | Generates the SQL that is required to update the database to the current version as specified in the DatabaseChangeLogs. |
| [liquibase:updateTestingRollback](http://site.kuali.org/db/liquibase/2.0.2/liquibase-maven-plugin/updateTestingRollback-mojo.html) | Applies the DatabaseChangeLogs to the database, testing rollback. This is done by updating the database, rolling it back then updating it again. |



### System Requirements

The following specifies the minimum requirements to run this Maven plugin:

| Maven      | 2.0                     |
| ---------- | ----------------------- |
| JDK        | 1.6                     |
| Memory     | No minimum requirement. |
| Disk Space | No minimum requirement. |



## 概要流程

**1.dif差异性**

执行mvn org.liquibase:liquibase-maven-plugin:3.8.5:diff,将会在配置路径生成如下changelog.xml

<img src="all_images/image-20200426154336753.png" width=70% height=70% />



**2.将生成的差异性changelog.xml放入changeling-master.xml**

<img src="all_images/image-20200426154540721.png" width=70% height=70% />



**3.编译并构建服务，服务执行时会执行update命令，check变更并sync变更。**

**4.sync变更前后DATABASECHANGELOG表变更**

update执行前，查看DATABASECHANGELOG已执行的changelog.xml

<img src="all_images/image-20200426152615064.png" width=70% height=70% />



update执行后，变更后查看DATABASECHANGELOG、task_data_source表,发现本次diff出来的变更已加入DATABASECHANGELOG，task_data_source表的变更也执行了。

DATABASECHANGELOG chanlog执行轨迹

<img src="all_images/image-20200426152735764.png" width=70% height=70% />



task_data_source表变更

<img src="all_images/image-20200426155138453.png" width=70% height=70% />



