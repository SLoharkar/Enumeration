printf " Automatically Check dependencies and Install "
a1=("hydra" "nmap" "dnsenum")
i=0
while [ $i -lt 4 ]
do
if ! which ${a1[$i]}  > /dev/null; then
	sudo apt install ${a1[$i]} >/dev/null 2>&1 
	
fi
i=`expr $i + 1`
done 
clear

int=""
hello ()
{
	printf "\nEnter the website or ip to enumeration\t "
       read ip
	if [ "$ip" = "" ]
	then
		printf "Please enter the website or ip to enumeration"
	fi	
}

hello1 ()
{
	if [ "$ip" != "" ] 
	then
	printf "\nEnter port number or port name to scan\t"
	read port
	if [ "$port" = "" ]
	then
	printf "\nPlease enter the port number or port name\t"
	fi
	fi
}
hello2 ()
{
if [ "$port" != "" ]
then
	printf "\nEnter the script name "
	read scr
	if [ "$scr" = "" ]
	then
		printf "\nPlease Enter the script "
	fi
fi
}

up() {					

	if [[ "$user2" != *".txt"* ]] && [[ "$pass2" != *".txt"* ]]
	then
		hydra -l $user2 -p $pass2 $ip $int
		fi
	}

upf() {

	if [[ "$user2" != *".txt"* ]] && [[ "$pass1" = *".txt"* ]]
	then
		hydra -l $user2 -P $pass1 $ip $int
		fi
	}

ufp() {
	if [[ "$user1" = *".txt"* ]]  && [[ "$pass2" != *".txt"*  ]]
	then
		hydra -L $user1 -p $pass2 $ip $int
	fi
}

ufpf() {
	if [[ "$user1" = *".txt"* ]] && [[ "$pass1" = *".txt"* ]]
	then
		hydra -L $user1 -P $pass1 $ip $int
	fi
}	

while [ true ]
do
	printf "\t\t\t Enumeration \n\n\n1 Nmap Script Engine\n2 Nmap Script Engine with port\n3 Nmap Script Engine with Script name\n4 Nmap Script Engine with Script name with port\n5 Dnsenum\n6 FTP Login\n7 SSH Login\n8 Hydra Tool\n9 Clear\n10 Exit  "
	printf "\n\nEnter the choice\t"
	read ch
	case "$ch" in
		"1")
			hello
			if [ "$ip" != "" ]
			then
			nmap -sC $ip
			read -t 1000
			fi
			;;

		"2") 
			hello
			hello1
			if [ "$port" != "" ]
			then
				nmap -sC -p$port $ip
				read -t 1000
			fi
			;;
		"3")
			hello
			hello2
			if [ "$scr" != "" ]
			then
				nmap -script $scr $ip
				read -t 1000
			fi
			;;
		"4")
			hello
			hello1
			hello2
			if [ "$scr" != "" ]
			then
				nmap -p $port -script $scr $ip
				read -t 1000
			fi
			;;
		"5")
			hello
			if [ "$ip" != "" ]
			then
				dnsenum $ip
				read -t 1000

			fi
			;;
		"6")
			hello
			if [ "$ip" != "" ]
			then
				ftp $ip
				read -t 1000
			fi
			;;
		"7")
			hello
			if [ "$ip" != "" ]
			then
				printf " Enter the username of ssh "
				read user
				if [ "$user" = "" ]
				then
					printf " Please enter the username of ssh "
				else
				ssh $user@$ip
				read -t 1000
				fi
			fi
			;;
		"8")
			hello
			while [ true ]
			do
				int=""
				printf "\nChoose Below Login Credentials\n1 SSH\n2 Telnet\n3 FTP\n4 Exit\t"
			       read ch1	
				case "$ch1" in 
					"1")
						int="ssh -t 4"
						break
						;;
					"2")
						int="telnet"
						break
						;;
					"3")
						int="ftp"
						break
						;;
					"4")
						break
						;;
					*)
						printf " Invalid Choice "
						read -t 1000
						;;
				esac
			done
			user1=""
			user2=""
			pass1=""
			pass2=""
			if [ "$ip" != "" ] && [ "$int" != "" ]
				then
				printf " Enter the username or enter the username file with .txt "
				read user
				printf " Enter the password or enter password file with .txt "
				read pass
				
				if [ "$user" = "" ] || [ "$pass" = "" ] 
				then
					printf " Please enter the username or password or file with .txt "
				else

					if [ "$user" != "" ] && [[ "$user" = *".txt"* ]] 
					then
						user1=$user
					else
						user2=$user
					fi

					if [ "$pass"  != "" ] && [[ "$pass" = *".txt"* ]]
					then
						pass1=$pass
					else
						pass2=$pass
					fi

					if [ "$user1" != "" ] || [ "$user2" != "" ]
					then
						up
						upf
						ufp
						ufpf

					fi	

				fi
			else
				printf "\nPlease Choose the login Credentials\n "

			fi
			;;
		"9")
			clear
			;;
		"10")
			exit
			;;

		*)
			echo " Please Choose correct option "
			read -t 1000
			;;
	esac
done
