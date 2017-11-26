Channel.from( 0..40 ).into { zeroToSixity1; zeroToSixity2 } 


process prepareToSleep {
	
	tag { x } 

	input:
	val x from zeroToSixity1
	
	output:
	file("sleep_script_${x}.sh") into sleep_script_files

	shell:
	"""
	echo "sleep \$(( RANDOM % (10 - 5 + 1 ) + 5 ))">sleep_script_!{x}.sh
	"""
}


process actuallySleep {
	tag { y }	

	input:
	val y from zeroToSixity2
	file z from sleep_script_files

	shell:
	"""
	/bin/bash !{z}
	"""

}
