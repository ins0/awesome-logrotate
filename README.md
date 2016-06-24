# Awesome logrotate

## Description
This script will check if your log is larger than 10 MB or older than seven days. If true, the script will archive the current logfile and supply it with a timestamp. I actually have no idea what I'm doing here. This is a logrotate script in bash. You know what it's good for. If you have any feature requests, don't hesitate to text me or open an issue.

###### Feature tracker
- [X] Nothing yet

## HOW TO USE
1. In order to use this script, you have to clone it to your own environment:

    ```bash
git clone https://github.com/hermsicodes/awesome-logrotate.git
    ```

2. (OPTIONAL) If you want to change the default max-size or max-age, open the scriptfile with your editor of choice and change "SIZE" or "AGE" to the desired values.
    ```bash
    cd awesome-logrotate
    vim logrotate.sh
      SIZE=DESIRED # MB
      AGE=DESIRED # DAYS
    ```

3. Afterwards, change directory, run logrotate.sh and use STDIN to specify the logfile you want to rotate. Please use absolute paths here:

    ```bash
cd awesome-logrotate
./logrotate.sh /PATH/TO/FILE.log
```

4. Have fun with your rotated logfile. You can also schedule this script via crontab or cronjob in general. Simply copy the command above and insert it.

###### Made by [Dennis Hermsmeier](https://twitter.com/hermsi_codes)
