#! /bin/sh
(
###############
## Variables ##
###############
echo "Set variables:"
install_dir=`pwd`
current_dir_path=`pwd`
binaries_tar=$current_dir_path"/files/third_party_binaries-src.tar-Linux.gz"
file_name="third_party_binaries-src.tar-Linux.gz"
DOMINO_error=$current_dir_path"/DOMINO_install_logfile.txt"
echo "INSTALL DIR: "$install_dir
echo "CURRENT DIR: "$current_dir_path
echo "LOGFILE: "$DOMINO_error
echo ""

#################
## Directories ##
#################
bin_folder=$install_dir"/bin"
scripts_folder=$bin_folder"/scripts"
tmp_dir_path=$install_dir"/tmp_dir"
mkdir $bin_folder
mkdir $scripts_folder
mkdir $tmp_dir_path

echo "Generate directories:"
echo $bin_folder
echo $scripts_folder
echo $tmp_dir_path
echo ""

#############################
## Start the installation ###
#############################
echo ""
echo "Start the installation"
echo ""
cp $binaries_tar $tmp_dir_path
cd $tmp_dir_path
echo ""
echo "Extracting file: "$file_name
echo ""
tar -zxvf "./"$file_name
cd binaries
ls | while read folder_tar_gz
do
	echo ""
	cd $folder_tar_gz
	ls | while read tar_gz
	do
		echo ""
		echo "Extracting: "$tar_gz
		tar -zxvf $tar_gz
		rm $tar_gz

		if [ "$folder_tar_gz" = "SPADES" ];
		then
			echo ""
			echo "SPADES installation"
			mv SPAdes-3.8.1-Linux $scripts_folder
		fi

		if [ "$folder_tar_gz" = "CAP3" ];
		then
                        echo ""
			echo "CAP3 installation"
			mkdir -p $scripts_folder"/cap3/bin"
			mv CAP3"/"cap3 $scripts_folder"/"cap3"/"bin
			mv CAP3"/"README $scripts_folder"/"cap3
			mv CAP3"/"doc $scripts_folder"/"cap3
		fi

		if [ "$folder_tar_gz" = "bowtie" ];
		then
                        echo ""
			echo "BOWTIE2 installation"
			mkdir -p $scripts_folder"/bowtie2-2.2.9"
			cd bowtie2-2.2.9
 			make >> $DOMINO_error
			mv bowtie2* $scripts_folder"/"bowtie2-2.2.9
			mv AUTHORS $scripts_folder"/"bowtie2-2.2.9
			mv LICENSE $scripts_folder"/"bowtie2-2.2.9
			mv VERSION $scripts_folder"/"bowtie2-2.2.9
		fi

		if [ "$folder_tar_gz" = "mothur" ];
		then 
			echo ""
			echo "MOTHUR installation"
			mkdir -p $scripts_folder"/MOTHUR_v1.32.0"
			mv mothur"/"mothur $scripts_folder"/"MOTHUR_v1.32.0
			mv mothur"/"LICENSE $scripts_folder"/"MOTHUR_v1.32.0
		fi
		if [ "$folder_tar_gz" = "prinseq" ];
		then
                        echo ""
			echo "PRINSEQ installation"
			mkdir -p $scripts_folder"/"PRINSEQ-lite_0.20.4
			mv prinseq-lite-0.20.4"/"prinseq-lite.pl $scripts_folder"/"PRINSEQ-lite_0.20.4			
			mv prinseq-lite-0.20.4"/"README $scripts_folder"/"PRINSEQ-lite_0.20.4			
			mv prinseq-lite-0.20.4"/"COPYING $scripts_folder"/"PRINSEQ-lite_0.20.4
		fi

		if [ "$folder_tar_gz" = "MIRA" ]
		then
                        echo ""
			echo "MIRA installation"
			mkdir -p $scripts_folder"/mira_v4.0/bin"
			mira_folder=mira_4.0.2_linux-gnu_x86_64_static
			mv $mira_folder"/"bin"/"mira $scripts_folder"/"mira_v4.0"/"bin
			mv $mira_folder"/"LICENCE $scripts_folder"/"mira_v4.0
			mv $mira_folder"/"README $scripts_folder"/"mira_v4.0
		fi

		if [ "$folder_tar_gz" = "NGSQC" ]
		then
		        echo ""
			echo "NGS QC Toolkit installation"
			mkdir -p $scripts_folder"/NGSQCToolkit_v2.3.1"
			mv NGSQCToolkit_v2.3.3"/"* $scripts_folder"/"NGSQCToolkit_v2.3.1
		fi

		if [ "$folder_tar_gz" = "NCBI" ]
		then
                        echo ""
			echo "BLAST installation"
			mkdir -p $scripts_folder"/NCBI_BLAST"
			cd blast
			ls | while read files
			do
				cp $files $scripts_folder"/NCBI_BLAST"
			done
		fi

		if [ "$folder_tar_gz" = "samtools" ]
		then
                        echo ""
			echo "SAMTOOLS installation"
			mkdir -p $scripts_folder"/samtools-1.3.1"
			cd samtools-1.3.1
 			make >> $DOMINO_error
			mv COPYING $scripts_folder"/"samtools-1.3.1
			mv AUTHORS $scripts_folder"/"samtools-1.3.1
			mv samtools $scripts_folder"/"samtools-1.3.1
		fi
	done
	cd $tmp_dir_path"/"binaries
done
echo ""
echo "Install Perl modules and dependencies"
echo ""

########################################
## install perl modules: NGSQCTOOLKIT ##
########################################
cp $current_dir_path"/files/tarGZ_modules_Perl_NGSQCToolkit.tar.gz" $tmp_dir_path
cd $tmp_dir_path
echo ""
echo "Extracting tarGZ_modules_Perl_NGSQCToolkit.tar.gz"
tar -zxvf "./tarGZ_modules_Perl_NGSQCToolkit.tar.gz"
cd $current_dir
echo ""
perl $current_dir_path"/files/unzip_install_NGSQCtoolkit_modules.pl" $tmp_dir_path"/tarGZ_modules_Perl_NGSQCToolkit" $scripts_folder"/NGSQCToolkit_v2.3.1"
echo ""

#################################
## install perl modules DOMINO ##
#################################
cp $current_dir_path"/files/tarGZ_modules_Perl.tar.gz" $tmp_dir_path
cd $tmp_dir_path
echo "Extract tarGZ_modules_Perl.tar.gz"
tar -zxvf "./tarGZ_modules_Perl.tar.gz"
cd $current_dir_path
perl $current_dir_path"/files/unzip_install_perl_modules.pl" $tmp_dir_path"/tarGZ_modules_Perl" $scripts_folder
cp -r $scripts_folder"/NGSQCToolkit_v2.3.1/lib/Parallel/" $scripts_folder"/lib/"
cp -r $scripts_folder"/NGSQCToolkit_v2.3.1/lib/Exporter/" $scripts_folder"/lib/"
echo ""

################
## db_default ##
################
echo ""
echo "Get default database search files"
cp $current_dir_path"/files/db_default.tar.gz" $scripts_folder
cd $scripts_folder
tar -zxvf "db_default.tar.gz"
rm -r "db_default.tar.gz"
cd $install_dir

rm -rf $tmp_dir_path
echo ""

########################
## Copy DOMINO perl code ##
########################
ls $current_dir_path"/src/perl/" | while read files
do
	cp $current_dir_path"/src/perl/"$files $scripts_folder
done
mv $scripts_folder"/DOMINO.pm" $scripts_folder"/lib"
) 2>&1 | tee DOMINO_install_logfile.txt
