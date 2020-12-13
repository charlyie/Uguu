# Uguu *Improved*

This version is a custom, enhanced & UI-simplified version of [Uguu](https://github.com/nokonoko/Uguu).
Uguu is a simple lightweight temporary file uploading and sharing platform where files get deleted after X amount of time.

![Uguu Improved Screenshot](https://i.ibb.co/gV7p6Y1/uguu-screenshot.jpg)

## What's improved ?

- UI simplified
- Install scripts
- Minor bug fixes
- Link to [Uguu Bash Client](https://github.com/charlyie/uguu-client)

## Features

- One click uploading, no registration required
- A minimal, modern web interface
- Drag & drop supported
- Upload API with multiple response choices
  - JSON
  - HTML
  - Text
  - CSV
- Supports [ShareX](https://getsharex.com/) and other screenshot tools


## Requirements

- Apache/Nginx
- PHP 7+
- SQLite enabled

## Install

For the purposes of this guide, we won't cover setting up Apache/Nginx, PHP, SQLite,
Node, or NPM. So we'll just assume you already have them all running well.

**NPM/Node is only needed to compile the files, Uguu runs on PHP.**

### Compiling

First you must get a copy of the uguu code.  To do so, clone this git repo.
```bash
git clone https://github.com/charlyie/Uguu
```

Assuming you already have Node and NPM working, compilation is easy.

Run the following commands to do so, please configure `dist.json` before you compile.
```bash
cd uguu/
chmod +x install.sh
./install.sh
```

After this, the uguu site is now compressed and set up inside `dist/`, or, if specified, `DESTDIR`.

## Configuring

Front-end related settings, such as the name of the site, and maximum allowable
file size, are found in `dist.json`.  Changes made here will
only take effect after rebuilding the site pages.  This may be done by running
`make` from the root of the site directory.

Back-end related settings, such as database configuration, and path for uploaded files, are found in `includes/settings.inc.php`.  Changes made here take effect immediately. Change the following settings:
```php
define('UGUU_DB_CONN', 'sqlite:/path/to/db/data.sq3');
define('UGUU_FILES_ROOT', '/path/to/file/');
define('UGUU_URL', 'https://subdomainforyourfiles.your.site');
```

If you intend to allow uploading files larger than 2 MB, you may also need to
increase POST size limits in `php.ini` and webserver configuration. For PHP,
modify `upload_max_filesize` and `post_max_size` values. The configuration
option for nginx webserver is `client_max_body_size`.

Then add them to your crontab:
```bash
0,30 * * * * bash /path/to/checkfiles.sh
0,30 * * * * bash /path/to/checkdb.sh
```

These scripts check if DB entries and files are older then 24 hours and if they are deletes them.

## MIME/EXT Blocking

Blocking certain filetypes from being uploaded can be changed by editing the following settings in `includes/settings.inc.php`:
```php
define('CONFIG_BLOCKED_EXTENSIONS', serialize(['exe', 'scr', 'com', 'vbs', 'bat', 'cmd', 'htm', 'html', 'jar', 'msi', 'apk', 'phtml']));
define('CONFIG_BLOCKED_MIME', serialize(['application/msword', 'text/html', 'application/x-dosexec', 'application/java', 'application/java-archive', 'application/x-executable', 'application/x-mach-binary']));
```

By default the most common malicious filetypes are blocked.

## Using SQLite as DB engine

We need to create the SQLite database before it may be used by uguu.
Fortunately, this is incredibly simple.  

By running install.sh, a data.sq3 file has been created to the root of the project.

Finally, edit `includes/settings.inc.php` to indicate this is the database engine you would like to use.  Make the changes outlined below
```php
define('UGUU_DB_CONN', '[stuff]'); ---> define('UGUU_DB_CONN', 'sqlite:/var/db/uguu/uguu.sq3');
define('UGUU_DB_USER', '[stuff]'); ---> define('UGUU_DB_USER', null);
define('UGUU_DB_PASS', '[stuff]'); ---> define('UGUU_DB_PASS', null);
```

*NOTE: The directory where the SQLite database is stored, must be writable by the web server user*

## API
To upload using curl or make a tool you can post using: 
```
curl -i -F files[]=@yourfile.jpeg https://uguu.se/upload.php (JSON Response)
```
```
curl -i -F files[]=@yourfile.jpeg https://uguu.se/upload.php?output=text (Text Response)
```
```
curl -i -F files[]=@yourfile.jpeg https://uguu.se/upload.php?output=csv (CSV Response)
```
```
curl -i -F files[]=@yourfile.jpeg https://uguu.se/upload.php?output=html (HTML Response)
```

## Credits

Uguu is based on [Pomf](http://github.com/pomf/pomf).

Uguu improved by [Charles Bourgeaux](https://github.com/charlyie)

## License

Uguu is free software, and is released under the terms of the Expat license. See
`LICENSE`.
