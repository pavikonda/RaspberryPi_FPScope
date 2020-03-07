/*

Designed to hold a Raspberry Pi camera module, and fit into mount_holder.scad

Design by Tomas Aidukas, modified by Victor Lovic

*/

// Y is along the cable
camera_w_y = 25.2;
camera_w_x = 24.2;
$fn = 100;
height=14.5-2.8;
wall_thick=4;
lens_height=4;

//Lens is pushed by 1mm from the bottom + its height is 4z.5mm + 6mm distance to the detector lens + the lens sits 6.5mm away from the support. Hence the support should be built 18mm from the bottom
cam_holder = 18;

// Camera platform
difference(){        
        cube([camera_w_x+wall_thick,camera_w_y+wall_thick,height],center=true);
        
    // Crop the top
    translate([0,0,height/2]){
        cube([camera_w_x+1+wall_thick,camera_w_y+1+wall_thick,3],center=true);}
    translate([-10,0,height/2]){
        cube([camera_w_x+10+wall_thick,21.5,4],center=true);}
        
    // Hole inside
    translate([0,0,lens_height]){    
        cube([camera_w_x-2,camera_w_y-9,height+1],center=true);}
    
    // Lens is pushed up by 1mm from the bottomm + its height of 3mm gives 4mm from the bottom of the holder to the top aperture plastic
    translate([-2.5,0,-height/2+lens_height/2+1]){        
        cylinder(d=6, h=lens_height,center=true);}
    
    translate([-2.5,0,-height/2+lens_height/2-1]){        
        cylinder(d=4, h=lens_height,center=true);}
    
    // Camera Holder. The sensor chip sits heigth - 4mm (lens top) - 2mm crop from the top of the lens  = 8mm  . But we also crop 1mm from the bottom of the sensor giving uz 7mm separation from the top lens plastic  to the sensor. Since we need 7.5mm the esensor height = 7.5mm + 2mm + 4mm = 13.5mm
        
    translate([0,0,height/2]){        
        cube([camera_w_x,camera_w_y,4],center=true);}
        
               
    // Camera screw holes
     translate([-24/2+9.5,21/2,height/2-2]){
         cylinder(d=1.5,h=10,center=true);}     
     translate([-24/2+9.5,-21/2,height/2-2]){
         cylinder(d=1.5,h=10,center=true);}
      translate([-24/2+22,21/2,height/2-2]){
         cylinder(d=1.5,h=10,center=true);}
      translate([-24/2+22,-21/2,height/2-2]){
         cylinder(d=1.5,h=10,center=true);}// Camera screw holes END   
         
}



// Slider
// angle is tan(delta_h/slider_hole_w_h)
slider_hole_w_h = 30; 
slider_x_shift_h = 10;
slider_z_shift_h = -10;
delta_h = -20;
$fn = 100;
height1 = height-1.5+2.8+4;
// To get the same angle we need arctan(tan(delta_h/slider_hole_w_h))*slider_hole_w = delta

//30mm is too loose
slider_hole_w = 30; 
slider_x_shift = 10;
slider_z_shift = -10;
//delta = -20;
delta = atan(tan(delta_h/slider_hole_w_h))*slider_hole_w;

camera_w = 25+4;

translate([13,0,height/2+2+2.8+2]){
difference(){
    hull(){
        translate([slider_x_shift,slider_hole_w/2,slider_z_shift]){
            cube([0.1,0.1,height1], center=true);
        }
        
        translate([slider_x_shift,-slider_hole_w/2,slider_z_shift]){
            cube([0.1,0.1,height1], center=true);
        }
        
        translate([slider_x_shift+delta,0,slider_z_shift]){
            cube([0.1,0.1,height1], center=true);
        }
    }    
        // Large block chop
        translate([-18,0,-10]){
            cube([40,70,80], center=true);
        }
            
        //Screw
        translate([6,0,5]){
            cylinder(d=3.5,h=30,center=true);}
        //Screw END 
  
    // Spring Holes
    translate([6,6.5,14.5]){
        cylinder(d=5.6,h=200,center=true);}
    translate([6,-6.5,14.5]){
        cylinder(d=5.6,h=200,center=true);}// Spring Holes END
        
        //spring  holder hole
        translate([5.5,0,-height1-2]){
        cube([2,26,4.2],center=true);}
        
}
    // Connector
    translate([1.8,0,-10]){        
        cube([2.8,camera_w/2+5-2,height1],center=true);}
   
   /*     
// Spring holder
    translate([5.5,3,-height1-3.5]){
        cube([1,7,2]);}
        
    translate([5.5,-10,-height1-3.5]){
        cube([1,7,2]);}// Spring holder END
        
    */
}


    

    
// Connector 2.5mm length
// Centre to connector 29/2 = 14.5mm 
// slider is 6.8mm
// Total: 23.8mm from the centre to the edge
    
// Holder mount to back is 10.3mm
// 2.2 and 1.6 are the edge thicknesses around the screw. 6.4mm is the screw thickness. So, 1.6mm + 3.2mm = 4.8mm from the wall to the center.
    
// Final Calc gives 4.8mm + 23.8mm = 28.6mm from the centre to where the holes should be
