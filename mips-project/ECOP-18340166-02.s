	.data    # �������ݶΣ����ݽ�����ڴ�
sentence1:   # �����������ʵ����һ����ַ
	.asciiz "Please enter the integers with zero to finish:\n"
endl:
	.asciiz "\n"           # αָ��
str:                       # ��������ַ���
	.space 60
string:
	.space 4               # ��������ַ���
	.set noreorder         # ������αָ�������

	.text                  # ����Σ���ִ�еĴ������ڴ�
.global main               # ָ��mainΪȫ�����������
main:
	li $v0, 4004           # ���ú�4004��write������$v0
	li $a0, 1              # Ŀ��1���ļ�����׼���������$a0
	la $a1, sentence1      # ��������ַ����׵�ַ����$a1
	li $a2, 47             # Ҫ����ֽ���Ϊ47������$a2
	syscall                # ׼�������������ں���ɵ���
	li $t0, 48             # '0'
	li $t1, 49             # '1'
	li $t2, 50             # '2'
	li $t3, 0              # ���answer
	li $t4, 0              # $t4���������2�ĸ���

	li $v0, 4003           # ���ú�4003��read������$v0
	li $a0, 0			   # Ŀ��0���ļ�����׼���룩����$a0
	la $a1, str            # $a1��������ַ���str���׵�ַ
	li $a2, 60             # ��ȡ60���ֽ�
	syscall                # ׼�������������ں���ɵ���
	la $t5, str            # $t5��������ַ���str���׵�ַ
loop:
	lb $t6, 0($t5)         # ��һ���ֽڴ��ڴ�ȡ���Ĵ���$t6��
	beq $t6, $t0, print    # �����0��ֱ��������
	nop                    # important to make program happy
	beq $t6, $t1, addone   # �����1����ת��addone
	nop
	beq $t6, $t2, addtwo   # �����2����ת��addtwo
	nop
addone:
	addi $t3, $t3, 1       # $t3++
	li $t4, 0              # $t4����
	addi $t5, $t5, 2       # $t5=$t5+2(�����ո�����һ����)
	j loop                 # ��������ת
	nop
addtwo:
	addi $t4, $t4, 1       # $t4++
	add $t7, $t4, $t4      # $t7=2*$t4
	add $t3, $t3, $t7      # $t3=$t7+$t3
	addi $t5, $t5, 2       # ����ȡ�ĵ�ַ�����ֽڣ������ո�
	j loop  
	nop
print:
	addi $a0, $t3, 0       # ����
	jal printfunc          # ���̵��ã�jump and link
	nop

	li $v0, 4001           # ���ú�4001(exit)����$v0
	syscall                # ׼�������������ں���ɵ���


.global printfunc
printfunc:
	addi $t0, $a0, 0       # $t0=$a0
	li $t2, 2              # ��Ҫ�Ŀռ�-1
	li $t5, 2              # ���������������ַ�����
	la $t3, string         # ���һ���ַ��ĵ�ַ��$t3+$t2��
loop2:
	rem $t1, $t0, 10       # $t1������
	div $t0, $t0, 10       # $t0=$t0/10
	addi $t1, $t1, 48      # ת��Ϊ�ַ�
	add $t4, $t3, $t2      # �洢��ַ
	sb $t1, 0($t4)         # ���ֽ�
	addi $t2, $t2, -1      # ��ǰŲһ���ֽ�
	beq $t0, $zero, printstring   # �����0������ѭ��
	nop
	j loop2                # �����Ϊ0������ѭ��
	nop
printstring:
	sub $a2, $t5, $t2         # Ҫ�����ô���ַ�
	addi $t2, $t2, 1          # ��ʼ������˳��
	li $v0, 4004              
	add $a1, $t3, $t2         # ��ʼ��ַ
	li $a0, 1                 # ��׼���
	syscall
endline:                      # ����
	li $v0, 4004              
	li $a0, 1
	la $a1, endl
	li $a2, 1                 
	syscall

	jr $ra                    # ���ؼĴ����еĵ�ַ
	nop
