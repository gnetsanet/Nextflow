process align {
  tag { myNum }
  input:
  val myNum from (['one','two','three', 'three', 'one', 'two', 'three', 'three', 'four'])

  output:
  //set val(myNum), file("*.bam") into alignment
  file("*.bam") into alignment

  script:
  """
  echo ${myNum} > ${myNum}.1.bam
  echo ${myNum} > ${myNum}.2.bam
  """
}

alignment
	.toList().flatten()
	.map {
		file -> tuple(file.baseName, file)
	}
	.groupTuple()
	//.subscribe { println it }
	.set { bamChan }

process combine {
  tag { myNum }
  input:
  set val(myNum), val(bams) from bamChan

  output:
  set val(myNum), file("*.txt") into result

  script:
  //println bams.join(" ")
  """
  cat ${bams.join(" ")}>${myNum}.txt
  """
}

result
    .map { it[1] }
    //.subscribe { println it }
    .set { kronaOuts }

process zipKronaReports {


  tag { "Zipping Krona Reports"}

  errorStrategy 'retry'
  maxRetries 3
  echo true


  input:
  val(kronas) from kronaOuts.collect()

  output:
  file("myZippedFile.zip") into zipOut 

  script:
  //println kronaOuts
  """
  zip -j  myZippedFile.zip  ${kronas.join(" ")}	
  """
  
}
