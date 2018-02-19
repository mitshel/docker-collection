#!/bin/bash

echo `date` $1 $2 >> /var/log/mediatomb/transcode.log

#vlc -vvv $1 -sout '#transcode{vcodec=mp4v,acodec=none,vb=128,deinterlace}:file{dst=$2}'
#vlc -I dummy rtsp://192.168.7.127:554/user=admin_password=19ldda74_channel=4_stream=0.sdp? --sout '#transcode{vcodec=mp4v,acodec=none,v00,deinterlace}:std{mux=mp4,dst=1.mp4,access=file} vlc:out'
vlc -I dummy $1 --sout '#transcode{vcodec=mp4v,acodec=none,v00,deinterlace}:std{mux=mp4,dst='$2',access=file} vlc:out'
#cvlc $1 --sout '#transcode{vcodec=mp4v,acodec=none,v00,deinterlace}:std{mux=mp4,dst='$2',access=file} vlc:out'
#vlc -vvv $1 --sout '#transcode{vcodec=mp4v,acodec=none,v00,deinterlace}:std{mux=mp4,dst='$2',access=file} vlc:out'


