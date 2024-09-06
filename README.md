# Pan-Analizer-Nyquist-Plugin-
This is a nyquist analyzer that tries to locate the center of the overview of a track.
# Why this plugin?
Often using Audacity for different purposes I thought it might be useful at least in remixes to have a quick overview detector of a musical instrument, since to get information about the overview I always used the Stereo Plan of the vamp plugins in Sonic Visualizer.. 
# Operation 
This plugin calculates an incremental median of the pan values of the two independent audio channels, then making a total median of the two channels.. 
# Installation
Download the file "Pan_Analizer" and go to this link about the nyquist plugin installing: https://manual.audacityteam.org/man/nyquist_plug_in_installer.html
# Known issues 
Unfortunately the incremental median is not perfect in all cases, sometimes giving unexpected results when for example there are many variations within the selection. It is also known the visible problem of performance, although it seems to crash wait and after a while will normally give the output.
# To use the plugin at its best
I guarantee the output quality with a medium-high success rate, especially works well with short selections with constant audio prevalent. Below I show an example of the output and view of the stereo plan plugin (in Sonic Visualizer) of the same audio track:

![analizer pan 1](https://github.com/user-attachments/assets/cfdc383d-bed2-4113-b148-fc230472dd09)

The same track with the Stereo Plan of the Vamp Plugins:

![analizer pan 2](https://github.com/user-attachments/assets/c3dbcafa-44db-4a99-957a-b298b7f056d2)


# Conclusions
This is the first version of this plugin, I am open to any changes and requests for improvement, just open a problem in the relevant section of this repository.
