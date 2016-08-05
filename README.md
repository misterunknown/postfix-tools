# postfix-tools
Tools and scripts around working with postfix

## ps-mailsize.pl

This script is an example policy server which only implements a message_size_limit 
per domain. You can use it like that:
```
/etc/postfix/master.cf:
  policy  unix  -       n       n       -       0       spawn
    user=nobody argv=/usr/local/bin/postfix_policy_server.pl

/etc/postfix/main.cf:
  smtpd_end_of_data_restrictions = check_policy_service unix:private/policy
```
The limits and domains are configurable within the script.
