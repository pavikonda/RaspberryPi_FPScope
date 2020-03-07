import time
import unicornhathd as unicorn # library for the LED array
import numpy as np
import picamera
import picamera.array
import io
from fractions import Fraction

"""
CODE USED TO TAKE DATA FOR FPM RECONSTRUCTION. IF YOU ARE NOT PLANNING TO RECONSTRUCT THE DATA THEN USE A DIFFERENT SCRIPT.

USER MUST SELECT THE EXPOSURE TIMES, FRAMERATES AND THE LED COLOR.
	EXPOSURES - A LIST OF TIMES IN MILISECONDS FOR EACH LED "SHELL" (CHANGE THESE TO IMPROVED SPEED, SNR ETC.)
	FRAMERATES - FRAMERATES MATCHING THE EXPOSURE TIMES
	COLOR_LIST - LED COLOR TO BE USED FOR IMAGE ACQUISITION
    
Before using the code create the required directories, did
not implement automatic directory creation.
They are: WHITE, RED, GREEN, BLUE, STABILITY

1. REMEMBER TO CHANGE OR SCALE THE EXPOSURES AND FRAMERATES FOR YOUR SPECIFIC SAMPLES. RED/BLUE/GREEN LEDS WILL REQUIRE DIFFERENT EXPOSURE TIMES.
2. ENSURE THAT NO EXTERNAL LIGHT IS PRESENT, THE MICROSCOPE NEEDS TO BE ISOLATED FROM LIGHT AND BE PLACED INSIDE A BOX
3. ENSURE THAT THE SAMPLE IS SECURELY MOUNTED SINCE IT WILL SLIDE ON THE SLIPPERY PLASTIC SURFACE (CLAMPS OF SOME SORT WORK WELL)
4. YOU CAN ALSO USE LESS LEDS, THE CURRENT SCRIPT TAKES 256 IMAGES (CHANGE X AND Y PARAMETERS)
"""
#exposures = np.array([60000,60000,60000,500000,1300000,2800000,5000000,6000000]) # <- exposures for highest possible SNR (sample specific)
#framerates = [Fraction(5,1),Fraction(5,1),Fraction(5,1),Fraction(2,1),Fraction(1,2),Fraction(1,3),Fraction(1,5),Fraction(1,6)]
exposures = np.array([60000,60000,60000,60000,60000,60000,60000,60000]) # <- Relatively fast exposures
framerates = [Fraction(5,1), Fraction(5,1), Fraction(5,1), Fraction(5,1), Fraction(5,1), Fraction(5,1), Fraction(5,1), Fraction(5,1)]
color_list = ['blue']

# 4 X 4 LED PATTERN WILL BE USED. CHANGE TO EVEN NUMBERS UP TO 16. E.G. 6X6, 8X8, 16X16 ETC.
X = 4
Y = 4







##################################################################
# Take images for each color
# "exposures" stores the exposure times for each LED shell
# central 4 LEDs used exposures[0]
# LEDs from 5 to 16 use exposures[1] etc..
# The LED shells end with 2^2, 2^4, 2^6 etc.. LEDs
# same applies to framerates, they must be matched to the exposures`
##################################################################
camera = picamera.PiCamera()
start_time = time.time()
unicorn.clear()
time.sleep(2)

for color in color_list:
    # coordinates of starting led, don't change
    x = y = 7
    dx = -1
    dy = 0  
    expo = 0

    unicorn.clear()
    unicorn.set_pixel(7,7,0,0,0)
    unicorn.show()

    if color == 'red':
        camera.framerate = framerates[expo]
        camera.shutter_speed = np.int(exposures[expo])
        foldname = 'RED'
    elif color == 'green':
        camera.framerate = framerates[expo]# * 2
        camera.shutter_speed = np.int(exposures[expo])
        foldname = 'GREEN'
    elif color == 'blue':
        camera.framerate = framerates[expo]# * 3
        camera.shutter_speed = np.int(exposures[expo])
        foldname = 'BLUE'
        
    # take a darkframe image
    stream = picamera.array.PiBayerArray(camera,output_dims=2)
    camera.capture(stream, 'jpeg', bayer=True)
    np.save('./Sequential/' + foldname + '/Darkframe_{}_color{}'.format(expo, color),stream.array)
        
    # Loop through the LEDs in the spiral and take images for each
    for i in range(X**2):
        # Take a darkframe 
        if i == 4 or i == 16 or i ==36 or i == 64 or i == 100 or i == 144 or i == 196:
            unicorn.set_pixel(x,y,0,0,0)    
            unicorn.show()

            expo += 1
            if color == 'red':
                camera.framerate = framerates[expo]
                camera.shutter_speed = np.int(exposures[expo])
                foldname = 'RED'
            elif color == 'green':
                camera.framerate = framerates[expo]# * 2
                camera.shutter_speed = np.int(exposures[expo])
                foldname = 'GREEN'
            elif color == 'blue':
                camera.framerate = framerates[expo]# * 3
                camera.shutter_speed = np.int(exposures[expo])
                foldname = 'BLUE'

            time.sleep(2)
            stream = picamera.array.PiBayerArray(camera,output_dims=2)
            camera.capture(stream, 'jpeg', bayer=True)
            np.save('./Sequential/' + foldname + '/Darkframe_{}_color{}'.format(expo, color),stream.array)

          
        if color == 'red':
            unicorn.set_pixel(x,y,255,0,0)
        elif color == 'green':
            unicorn.set_pixel(x,y,0,255,0)
        elif color == 'blue':
            unicorn.set_pixel(x,y,0,0,255)
            
        unicorn.show()
        unicorn.set_pixel(x,y,0,0,0) 

        
        # take BAYER picture and save
        time1 = time.time()
        stream = picamera.array.PiBayerArray(camera,output_dims=2)
        camera.capture(stream, 'jpeg', bayer=True)
        time2 = time.time()
        print('time to take picture: {}'.format(time2-time1))
                        
        time1 = time.time()
        np.save('./Sequential/' + foldname + '/ImgNo_{}_color{}'.format(i, color),stream.array)
        time2 = time.time()
        print('time to save picture: {}'.format(time2-time1))

        if x==y or (x+y == 15 and x <= 7) or (x+y == 14  and x > 7):
                dx, dy = dy, -dx
        x, y = x+dx, y+dy

    unicorn.clear()
    unicorn.set_pixel(7,7,0,0,0)
    unicorn.show()
        
end_time = time.time()
print('TOTAL TIME FOR RAW DATA ADQUISITION (sp?): {}'.format(end_time-start_time)) 


unicorn.clear()
unicorn.show()
camera.close()
