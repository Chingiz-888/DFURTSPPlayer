1) Just add new video file recieved from IP-cam (it can have extension .CGI) as internal resource in Xcode projet
(just do not forget to add this resource to target in other case this file will not be included during compilation!)

2) Change 2 variable in DFUViewController.m openVideoFunction()  relating to videoFilename and videoFilenameExtension

![cgi_playing](https://cloud.githubusercontent.com/assets/19972649/18820815/d70c1d6e-83b1-11e6-88a4-4ec05cffc0e6.png)

