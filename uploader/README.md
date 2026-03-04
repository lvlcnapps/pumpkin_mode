# How to use uploader

Create `/uploader/tocken.secret` file, put there your Exaroton token (on website: account->settings->API tocken). In `uploader/serverid` specify id of the server.

Upload folder to exaroton:
```
cd uploader
python3 upload.py -v --folder ../pumpkin_mode
```

- `-v` flag for verbose output, useful for debug
- `--folder` is for recursive copying, if not specified folder is uploaded as `.zip`. Note, that recursive copying is much slower

> may need to use `python` command for Windows