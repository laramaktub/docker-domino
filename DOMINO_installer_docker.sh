#! /bin/sh
(
############
## Variables ##
############
install_dir=`pwd`
current_dir_path=`pwd`
current_dir=$(dirname $current_dir_path)
binaries_tar=$current_dir_path"/files/"third_party_binaries-src.tar-Linux.gz
file_name=third_party_binaries-src.tar-Linux.gz

#############
## Directories ##
#############
bin_folder=$install_dir"/bin"
scripts_folder=$bin_folder"/scripts"
tmp_dir_path=$install_dir"/tmp_dir

mkdir $bin_folder
mkdir $scripts_folder
mkdir $tmp_dir_path

#####################
## Start the installation ###
#####################
cp $binaries_tar $tmp_dir_path
cd $tmp_dir_path
tar -zxvf "./"$file_name
cd binaries
ls | while read folder_tar_gz
do
	cd $folder_tar_gz
	ls | while read tar_gz
	do
		tar -zxvf $tar_gz
		rm $tar_gz

		if [ "$folder_tar_gz" = "SPADES" ];
		then
			mv SPAdes-3.8.1-Linux $scripts_folder
		fi

		if [ "$folder_tar_gz" = "CAP3" ];
		then
			mkdir -p $scripts_folder"/cap3/bin"
			mv CAP3"/"cap3 $scripts_folder"/"cap3"/"bin
			mv CAP3"/"README $scripts_folder"/"cap3
			mv CAP3"/"doc $scripts_folder"/"cap3
		fi

		if [ "$folder_tar_gz" = "bowtie" ];
		then
			mkdir -p $scripts_folder"/bowtie2-2.2.9"
			cd bowtie2-2.2.9
 			make > DOMINO_Error.log
			mv bowtie2* $scripts_folder"/"bowtie2-2.2.9
			mv AUTHORS $scripts_folder"/"bowtie2-2.2.9
			mv LICENSE $scripts_folder"/"bowtie2-2.2.9
			mv VERSION $scripts_folder"/"bowtie2-2.2.9
		fi
		
		if [ "$folder_tar_gz" = "mothur" ];
		then 
			mkdir -p $scripts_folder"/MOTHUR_v1.32.0"
			mv mothur"/"mothur $scripts_folder"/"MOTHUR_v1.32.0
			mv mothur"/"LICENSE $scripts_folder"/"MOTHUR_v1.32.0
		fi
		if [ "$folder_tar_gz" = "prinseq" ];
		then
			mkdir -p $scripts_folder"/"PRINSEQ-lite_0.20.4
			mv prinseq-lite-0.20.4"/"prinseq-lite.pl $scripts_folder"/"PRINSEQ-lite_0.20.4			
			mv prinseq-lite-0.20.4"/"README $scripts_folder"/"PRINSEQ-lite_0.20.4			
			mv prinseq-lite-0.20.4"/"COPYING $scripts_folder"/"PRINSEQ-lite_0.20.4
		fi

		if [ "$folder_tar_gz" = "MIRA" ]
		then
			mkdir -p $scripts_folder"/mira_v4.0/bin"
			mira_folder=mira_4.0.2_linux-gnu_x86_64_static
			mv $mira_folder"/"bin"/"mira $scripts_folder"/"mira_v4.0"/"bin
			mv $mira_folder"/"LICENCE $scripts_folder"/"mira_v4.0
			mv $mira_folder"/"README $scripts_folder"/"mira_v4.0
		fi			

		if [ "$folder_tar_gz" = "NGSQC" ]
		then
			mkdir -p $scripts_folder"/NGSQCToolkit_v2.3.1"
			mv NGSQCToolkit_v2.3.3"/"* $scripts_folder"/"NGSQCToolkit_v2.3.1
		fi

		if [ "$folder_tar_gz" = "NCBI" ]
		then
			mkdir -p $scripts_folder"/NCBI_BLAST"
			cd blast
			ls | while read files
			do
				cp $files $scripts_folder"/NCBI_BLAST"
			done
		fi
				
		if [ "$folder_tar_gz" = "samtools" ]
		then
			mkdir -p $scripts_folder"/samtools-1.3.1"
			cd samtools-1.3.1
 			make > DOMINO_Error.log
			mv COPYING $scripts_folder"/"samtools-1.3.1
			mv AUTHORS $scripts_folder"/"samtools-1.3.1
			mv samtools $scripts_folder"/"samtools-1.3.1
		fi			
	done
	cd $tmp_dir_path"/"binaries
done

#################################
## install perl modules: NGSQCTOOLKIT ##
#################################
cp $current_dir"/files/tarGZ_modules_Perl_NGSQCToolkit.tar.gz" $tmp_dir_path
cd $tmp_dir_path
tar -zxvf tarGZ_modules_Perl_NGSQCToolkit.tar.gz
cd $current_dir
perl $current_dir"/files/unzip_install_NGSQCtoolkit_modules.pl" $tmp_dir_path"/"tarGZ_modules_Perl_NGSQCToolkit $scripts_folder"/NGSQCToolkit_v2.3.1"

###########################
## install perl modules DOMINO ##
###########################
cp $current_dir"/files/tarGZ_modules_Perl.tar.gz" $tmp_dir_path
cd $tmp_dir_path
tar -zxvf tarGZ_modules_Perl.tar.gz
cd $current_dir
perl $current_dir"/files/unzip_install_perl_modules.pl" $tmp_dir_path"/"tarGZ_modules_Perl $scripts_folder
cp -r $install_dir"/bin/NGSQCToolkit_v2.3.1/lib/Parallel" $scripts_folder"/lib"

#############
## db_default ##
#############
cp $current_dir"/files/db_default.tar.gz" $scripts_folder
cd $scripts_folder
tar -zxvf "db_default.tar.gz"
rm -r "db_default.tar.gz"
cd $install_dir
rm -rf $tmp_dir_path

########################
## Copy DOMINO perl code ##
########################
ls "$current_dir/src/perl/" | while read files
do
	cp "$current_dir/src/perl/$files" $scripts_folder
done
mv "$install_dir/bin/DOMINO.pm" $scripts_folder"/lib"
) 2>>DOMINO_error.log
