$inner_diameter = 11.5/2; //Radius of batter wall (mm)

$battery_offset = 1;

$battery_height = 29.5;
//$battery_height = 5;

$pod_width = 1;
$pod_bottom = 1;

$number_of_batteries = 1;

$tolerence = 0.2;

$endcap_top = 1;

$peg_width = 4;

$keyway_width = 5;

//$number_of_fragents = 45;
$number_of_fragents = 90;

module reference_battery($fn = $number_of_fragents) {
    // reference stethoscope head as it was too complex to load into memory
    cylinder(h = $battery_height, r = $inner_diameter);

}

module pod($fn = $number_of_fragents) {


    difference() {
        
        cylinder(h = 5 + $pod_bottom, r =  $inner_diameter + $pod_width + $tolerence/2 + $pod_width);
        translate([0, 0, $pod_bottom])
        cylinder(h = $battery_height*3, r =  $inner_diameter + $pod_width + $tolerence/2);
          
    }
}


for (a =[0:1:$number_of_batteries - 1]){
    echo(a);
    translate(v = [0, 0, a*($battery_height + $tolerence)]){

//        translate([0, 0, $pod_bottom])
//        reference_battery();
        pod();
    }
}
