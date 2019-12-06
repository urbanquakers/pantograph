{!docs/includes/setup-pantograph-header.md!}

# Continuous Integration

_pantograph_ works very well in Continuous Integration setups.
It for example automatically generates a JUnit report for you that allows Continuous Integration systems, like `Jenkins`,
access the results of your deployment.

- [Integrations](#integrations)
- [Environment variables to set](#environment-variables-to-set)

## Integrations

Multiple CI products and services offer integrations with pantograph:

- [Jenkins](/best-practices/continuous-integration/jenkins/)
<!-- - [CircleCI](/best-practices/continuous-integration/circle-ci/) -->
<!-- - [Travis](/best-practices/continuous-integration/travis/) -->
<!-- - [Bamboo](/best-practices/continuous-integration/bamboo/) -->
<!-- - [GitLab CI](/best-practices/continuous-integration/gitlab/) -->
- [Azure DevOps](/best-practices/continuous-integration/azure-devops/) (formerly known as: Visual Studio Team Services)
<!-- - [NeverCode](/best-practices/continuous-integration/nevercode/) -->

## Environment variables to set

Most setups will need the following environment variables
- `LANG` and `LC_ALL`: These set up the locale your shell and all the commands you execute run at.
_pantograph_ needs these to be set to an UTF-8 locale to work correctly, for example `en_US.UTF-8`.
Many CI systems come with a locale that is unset or set to ASCII by default, so make sure to double-check whether yours is set correctly.

### Moved

<script type="text/javascript">
// Closure-wrapped for security.
(function () {
    var anchorMap = {
        "jenkins-integration": "/best-practices/continuous-integration/jenkins/",
        // "circleci-integration": "/best-practices/continuous-integration/circle-ci/",
        // "travis-integration": "/best-practices/continuous-integration/travis/",
        // "bamboo-integration": "/best-practices/continuous-integration/bamboo/",
        // "gitlab-ci-integration": "/best-practices/continuous-integration/gitlab/",
        "visual-studio-team-services": "/best-practices/continuous-integration/azure-devops/",
        // "nevercode-integration": "/best-practices/continuous-integration/nevercode/",
    }
    /*
    * Best practice for extracting hashes:
    * https://stackoverflow.com/a/10076097/151365
    */
    var hash = window.location.hash.substring(1);
    if (hash) {
        /*
        * Best practice for javascript redirects: 
        * https://stackoverflow.com/a/506004/151365
        */
        if (anchorMap[hash]) {
            link = anchorMap[hash] + '#' + hash;
            window.location.replace(link);
        }
    }
})();
</script>

The following tool- and service-specific content was moved:

#### Jenkins Integration

This content was moved and now lives [here](/best-practices/continuous-integration/jenkins/).

<!-- #### CircleCI Integration

This content was moved and now lives [here](/best-practices/continuous-integration/circle-ci/).

#### Travis Integration

This content was moved and now lives [here](/best-practices/continuous-integration/travis/).

#### Bamboo Integration

This content was moved and now lives [here](/best-practices/continuous-integration/bamboo/).

#### GitLab CI Integration

This content was moved and now lives [here](/best-practices/continuous-integration/gitlab/). -->

#### Visual Studio Team Services

This content was moved and now lives [here](/best-practices/continuous-integration/azure-devops/).

<!-- #### Nevercode Integration

This content was moved and now lives [here](/best-practices/continuous-integration/nevercode/). -->
