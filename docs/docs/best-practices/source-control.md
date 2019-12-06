## Source Control

It is recommended that you keep _pantograph_ configuration files in the repository.
You may want to add the following lines to the repository's `.gitignore` (Git) file to exclude generated and temporary files:

```shell
# pantograph specific
**/pantograph/report.xml

# generic output reports
**/pantograph/reports

# generic testing temporary files
**/pantograph/test_output
```

It is also recommended that you avoid storing screenshots or other delivery artifacts in the repository.
Instead, use _pantograph_ to re-generate whenever needed.
