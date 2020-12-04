#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
sqlite3 $DIR/data.sq3 "DELETE FROM files WHERE date <= strftime('%s', datetime('now', '-1 day'));"