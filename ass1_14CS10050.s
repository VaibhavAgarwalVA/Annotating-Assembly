	# Vaibhav Agarwal (14CS10050) Annotating Assembly - Compilers Lab, Assignment 1 .... Submitted on 26th July 2016
	
	.file	"ass1_14CS10050.c"                                 # file name
	.section	.rodata										   # read only data section
	.align 8												   # align with 8 byte boundary
	
.LC0:														   # label of f-string 1st printf
	.string	"Enter how many elements you want:"
.LC1:														   # label of f-string int scanf
	.string	"%d"
.LC2:                   									   # label of f-string 2nd printf
	.string	"Enter the %d elements:\n"
.LC3: 														   # label of f-string 3rd printf
	.string	"\nEnter the item to search"
.LC4:														   # label of f-string 4th printf					
	.string	"\n%d found in position: %d\n"		
.LC5:														   # label of f-string 5th printf
	.string	"\n%d inserted in position: %d\n"
.LC6:														   # label of f-string 6th printf
	.string	"The list of %d elements:\n"
.LC7:														   # label of f-string 7th printf
	.string	"%6d"
	
	.text													   # Text section keeps the actual code.
	.globl	main 											   # Tells the kernel that program execution starts here.
	.type	main, @function									   # Function prototype of "main". main begins here.
main:														   # main begins here



.LFB0:
	.cfi_startproc											   # "Call Frame Information". Used to manage call frames.
	pushq	%rbp											   # save old base pointer
	.cfi_def_cfa_offset 16									   # adding a new absolute offset
	.cfi_offset 6, -16										   # Previous value of register is saved at offset -16 from CFA.
	movq	%rsp, %rbp										   # changes the base pointer to the stack top pointer.
	.cfi_def_cfa_register 6                            		   # modifies the rule for computing cfa.
	
	subq	$416, %rsp 										   # allocate memory for all data members. readjust the top pointer. (4*100 + 4*4 = 416)                                           
	movl	$.LC0, %edi										   # edi -> 1st parameter of printf
	call	puts											   # calls puts for printf
	leaq	-416(%rbp), %rax								   # rax -> (rbp-416). So, now 'rax' points to the memory at top of stack.
	movq	%rax, %rsi										   # 'rsi' points to 'rax'.
	movl	$.LC1, %edi										   # edi -> string LC1 for printf									
	movl	$0, %eax										   # initializes the input value to be 0 before inputting.
	call	__isoc99_scanf									   # input the number through scanf in eax.
	movl	-416(%rbp), %eax								   # we take the value of entered 'n' in 'eax' register.                      
	movl	%eax, %esi										   # 'esi' points to 'eax'
	movl	$.LC2, %edi										   # edi -> string LC2 for printf
	movl	$0, %eax										   # clear the value of eax
	call	printf											   # printf routine called
	movl	$0, -408(%rbp)									   # assign 'rbp-408' , which is the address which stores 'i', to be 0.
	jmp	.L2													   # unconditional jump to statement block L2.
	
.L3:														   # block L3 begins here			
	leaq	-400(%rbp), %rax						           # passes the address of the array 'a' into 'rax'
	movl	-408(%rbp), %edx								   # 'edx' accesses the value of 'i'		
	movslq	%edx, %rdx										   # store the value of 'i' into 'rdx'
	salq	$2, %rdx										   # Multiply rdx by 4 to convert it into bytes (useful to shift memory bits).
	addq	%rdx, %rax 										   # shift the array pointer 'rax' by 'rdx' bytes (rdx = i*4)
	movq	%rax, %rsi										   # assign 'rsi' (input stream register) to 'rax' 
	movl	$.LC1, %edi										   # edi -> string LC1 for printf
	movl	$0, %eax										   # assign 'eax' to zero (to be inputted)
	call	__isoc99_scanf									   # input the value of a[i]
	addl	$1, -408(%rbp)									   # increment the value of 'i'
	
.L2:														   # block L2 begins here
	movl	-416(%rbp), %eax								   # assign the value of n in register 'eax'	
	cmpl	%eax, -408(%rbp) 								   # compare 'eax', which holds 'n', with 'i'
	jl	.L3													   # if less, execute block L3
	
	movl	-416(%rbp), %edx								   # take the value of 'n' into 'edx'
	leaq	-400(%rbp), %rax								   # takes the reference of array 'a' into 'rax'
	movl	%edx, %esi										   # 'esi' is the second parameter of insertion sort. (size)
	movq	%rax, %rdi										   # 'rdi' is the first parameter of insertion sort. (array)
	call	inst_sort										   # calls insertion sort function "inst_sort"
	
	movl	$.LC3, %edi										   # edi -> string LC3 for printf
	call	puts											   # calls the puts for printing the string
	leaq	-412(%rbp), %rax								   # assign 'rax' to the memory where 'item' will be stored	
	movq	%rax, %rsi										   # 'rax' is now 'rsi'
	movl	$.LC1, %edi										   # edi -> string LC1 for scanf
	movl	$0, %eax										   # assign zero as the initial value of 'eax'			
	call	__isoc99_scanf									   # input the value 'item' using scanf
	movl	-412(%rbp), %edx								   # third parameter for function call to be 'item'
	movl	-416(%rbp), %ecx								   # 'n' is now added into 'ecx'
	leaq	-400(%rbp), %rax								   # 'rax' now points to the starting index of array 'a'
	movl	%ecx, %esi										   # second parameter of function call to be 'n'
	movq	%rax, %rdi										   # first parameter of function call to be the array 'a'
	call	bsearch											   # call the function 'bsearch' for binary earching item from the array.
	
	movl	%eax, -404(%rbp)								   # assign the return value of 'bsearch' into memory location 404 variable 'loc'
	movl	-404(%rbp), %eax								   # eax gets the value of 'loc'
	cltq													   # type casts the value to int64
	movl	-400(%rbp,%rax,4), %edx							   # gets the value a[loc]
	movl	-412(%rbp), %eax								   # gets the value item
	cmpl	%eax, %edx										   # compares the values inside if
	jne	.L4													   # if not equal, call the else block
															   # 'if' block :								
	movl	-404(%rbp), %eax 								   # 'eax' gets the value 'loc'
	leal	1(%rax), %edx									   # add 1 to the value of 'loc' and store the outcome in 'edx', first parameter
	movl	-412(%rbp), %eax								   # 'eax' gets the value 'item'
	movl	%eax, %esi										   # 'eax' is assigned in the second parameter
	movl	$.LC4, %edi										   # edi -> LC4 string for printf
	movl	$0, %eax										   # clear the 'eax' to store return to zero
	call	printf											   # printf gets executed
	jmp	.L5													   # skip the 'else' block and move to L5 block
	
.L4:														   # else block
	movl	-412(%rbp), %edx								   # third parameter is assigned 'item'
	movl	-416(%rbp), %ecx								   # 'n' is added into 'ecx'
	leaq	-400(%rbp), %rax								   # 'rax' now points to the starting index of array 'a'
	movl	%ecx, %esi										   # second parameter is assigned 'n'
	movq	%rax, %rdi										   # the array 'a' is to be assigned into first parameter
	call	insert											   # calls 'insert' function
	movl	%eax, -404(%rbp)								   # assigns the return value from insert into 'loc'
	movl	-416(%rbp), %eax								   # 'eax' gets the value of 'n'
	addl	$1, %eax										   # increment the value at 'eax' by 1.
	movl	%eax, -416(%rbp)								   # storing the value at 'eax' back into 'n'. Effectively n++.
	movl	-404(%rbp), %eax 								   # 'eax' gets the value 'loc'
	leal	1(%rax), %edx									   # add 1 to the value of 'loc' and store the outcome in 'edx', first parameter
	movl	-412(%rbp), %eax								   # 'eax' gets the value 'item'
	movl	%eax, %esi										   # 'eax' is assigned in the second parameter
	movl	$.LC5, %edi										   # edi -> LC5 string for printf
	movl	$0, %eax										   # clear the 'eax' to store return to zero
	call	printf											   # printf gets executed
	
.L5:														   # L5 block. Printing the array.
	movl	-416(%rbp), %eax								   # 'eax' gets the value 'n'
	movl	%eax, %esi										   # second parameter gets the value of 'n'
	movl	$.LC6, %edi										   # edi -> LC6 string for printf
	movl	$0, %eax										   # clear the 'eax' to store return to zero
	call	printf											   # execute printf
	movl	$0, -408(%rbp)									   # make i = 0
	jmp	.L6													   # jump to segment L6, 'for' loop.	
	
.L7:														   # L7 block
	movl	-408(%rbp), %eax                  				   # 'eax' gets the value 'i'
	cltq													   # converts into int64
	movl	-400(%rbp,%rax,4), %eax							   # access the 'i'th element of the array 
	movl	%eax, %esi										   # assign a[i] to the second parameter
	movl	$.LC7, %edi										   # edi -> string LC7 for printf
	movl	$0, %eax										   # clear 'eax' and assign to zero
	call	printf											   # execute printf 
	addl	$1, -408(%rbp)									   # increment the value of 'i'
	
.L6:														   # L6 block
	movl	-416(%rbp), %eax								   # 'eax' gets the value of 'n'
	cmpl	%eax, -408(%rbp)								   # compare 'n' and 'i'
	jl	.L7													   # if 'n' is less than 'i', execute L7 block
	movl	$10, %edi										   # edi -> "\n" for printf
	call	putchar											   # executes putchar to print new line
	movl	$0, %eax										   # clear 'eax' and assign it zero
	leave													   # end of process
	.cfi_def_cfa 7, 8										   	
	ret														   # return zero
	.cfi_endproc											   # end of 'main' function
	
	
	
.LFE0:														   
	.size	main, .-main									   # main function calls this and value gets returned back to main 
	.globl	inst_sort										   # global function inst_sort
	.type	inst_sort, @function							   # function of name "inst_sort"
inst_sort:                       							   # inst_sort begins here
.LFB1:
	.cfi_startproc											   # Call frame information, procedure starts
	pushq	%rbp											   # Push old base pointer to stack.
	.cfi_def_cfa_offset 16									   # adding a new absolute offset
	.cfi_offset 6, -16										   # Previous value of register is saved at offset -16 from CFA.
	movq	%rsp, %rbp										   # assign base pointer to the value of stack pointer.
	.cfi_def_cfa_register 6									   # modifies the rule for computing cfa.
	movq	%rdi, -24(%rbp)									   # (rbp-24) memory address is being assigned with array pointer (first param)
	movl	%esi, -28(%rbp)									   # (rbp-28) memory address is being assigned with n (second param)
	movl	$1, -8(%rbp)									   #  assign 1 to j (memory address rbp-8)
	jmp	.L10												   # jump to and execute section L10
	
.L14:														   # code segment L14
	movl	-8(%rbp), %eax									   # 'eax' gets the value of 'j'
	cltq													   # convert 'eax' into int64
	leaq	0(,%rax,4), %rdx								   # store the index 'j' in bytes in 'rdx' (4*j)
	movq	-24(%rbp), %rax									   # 'rax' gets the reference of array 'num'.				
	addq	%rdx, %rax										   # move the reference by 'rdx' bytes ( go to num[j] )
	movl	(%rax), %eax								       # 'eax' gets the value of num[j]
	movl	%eax, -4(%rbp)									   # the value of 'eax' (i.e. num[j]) is assigned into 'k'.
	movl	-8(%rbp), %eax									   # 'eax' gets the value of 'j'
	subl	$1, %eax										   # subtract the value of 'eax' by 1 (you get 'j-1')
	movl	%eax, -12(%rbp)									   # 'i' (at address rbp-12) gets the value of 'eax' (equal to j-1)
	jmp	.L11												   # jump to segment L11
	
.L13:														   # segment L12
	movl	-12(%rbp), %eax									   # 'eax' gets the value of 'i'
	cltq													   # convert it into int64
	addq	$1, %rax										   # increase 'rax' by 1
	leaq	0(,%rax,4), %rdx								   # multiply by 4 to get the byte size
	movq	-24(%rbp), %rax									   # 'rax' gets the reference of array 'num'
	addq	%rax, %rdx										   # move the reference by byte size
	movl	-12(%rbp), %eax									   # 'eax' gets the value of 'i'
	cltq													   # convert it into int64
	leaq	0(,%rax,4), %rcx								   # convert into byte size by multiplying by 4
	movq	-24(%rbp), %rax									   # 'rax' gets the reference of the array
	addq	%rcx, %rax										   # move the reference by byte size (go to num[i])
	movl	(%rax), %eax									   # 'eax' gets the value of num[i]
	movl	%eax, (%rdx)									   # assign num[i+1] to be num[i]
	subl	$1, -12(%rbp)									   # decrement 'i'
	
.L11:														   # segment L11												
	cmpl	$0, -12(%rbp)									   # compare 'i' with 0
	js	.L12												   # if 0>i, jump to L12
	movl	-12(%rbp), %eax									   # assign 'eax' to 'i'
	cltq													   # convert 'eax' into int64
	leaq	0(,%rax,4), %rdx								   # multiply by 4 to convert into byte size (store in 'rdx')
	movq	-24(%rbp), %rax									   # 'rax' gets the reference of the array 'num'
	addq	%rdx, %rax										   # move the reference to 'num' by 'rdx' no of bytes (to num[i])
	movl	(%rax), %eax									   # convert 64 byte back into 32 bytes
	cmpl	-4(%rbp), %eax									   # compare num[i] with 'k'
	jg	.L13												   # if greater (num[i]>k), jump to segment L13 

.L12:														   # code segment L12
	movl	-12(%rbp), %eax									   # 'eax' gets the value of 'i'
	cltq													   # convert into int64
	addq	$1, %rax										   # increment 'i' by 1
	leaq	0(,%rax,4), %rdx								   # 'rdx' stores the size in bytes by multiplying by 4.
	movq	-24(%rbp), %rax									   # 'rax' gets the reference of array 'num'
	addq	%rax, %rdx										   # move the array pointer by 'rdx' bytes (to arr[i+1])
	movl	-4(%rbp), %eax									   # 'eax' gets the value of 'k' 
	movl	%eax, (%rdx)									   # assign num[i+1] to be 'k'
	addl	$1, -8(%rbp)									   # increment 'j' in for loop
	
.L10:														   # section L10 	
	movl	-8(%rbp), %eax									   # 'eax' gets the value of 'j'
	cmpl	-28(%rbp), %eax									   # we compare 'j' with 'n'
	jl	.L14												   # if j<n, compute section L14
	popq	%rbp											   # pop the stack base pointer from the stack
	.cfi_def_cfa 7, 8
	ret														   # return back to call
	.cfi_endproc											   # end the function
	
	
	
.LFE1:														   
	.size	inst_sort, .-inst_sort
	.globl	bsearch											   # global function 'bsearch'
	.type	bsearch, @function								   # function 'bsearch'
bsearch:													   # function begins
.LFB2:
	.cfi_startproc											   # start procedure
	pushq	%rbp											   # push the stack base pointer in stack
	.cfi_def_cfa_offset 16									   # set a absolute offset
	.cfi_offset 6, -16										   # Previous value of register is saved at offset -16 from CFA.
	movq	%rsp, %rbp 										   # rearrange the base pointer to the stack pointer
	.cfi_def_cfa_register 6									   # modifies the rule for computing cfa.
	movq	%rdi, -24(%rbp)									   # first parameter stored in rbp-24 'a'
	movl	%esi, -28(%rbp)									   # second parameter stored in rbp-28 'n'
	movl	%edx, -32(%rbp)                                    # third parameter stored in rbp-32 'item'
	movl	$1, -8(%rbp)									   # 'bottom' is assigned 1.
	movl	-28(%rbp), %eax									   # 'eax' gets the value 'n'
	movl	%eax, -12(%rbp)									   # 'top' gets the value of 'eax' (top=n)
	
.L19: 														   # code segment L19
	movl	-12(%rbp), %eax									   # 'eax' gets the value of 'top'
	movl	-8(%rbp), %edx									   # 'edx' gets the value of 'bottom'
	addl	%edx, %eax										   # add top and bottom
	movl	%eax, %edx										   # 'edx' gets the value of 'eax'
	shrl	$31, %edx										   # right shift 'edx' by 2^31 (to get the msb of the sum)
	addl	%edx, %eax										   # add edx ( which has "top + bottom" ) and the overflow from division. (2s complement if the number is negative)
	sarl	%eax											   # divide it by 2.
	movl	%eax, -4(%rbp)									   # assign the result in 'mid'
	movl	-4(%rbp), %eax									   # 'eax' gets the value of 'mid'
	cltq      												   # convert into int64
	leaq	0(,%rax,4), %rdx							       # multiply 'mid' by 4 to convert into bytes
	movq	-24(%rbp), %rax									   # 'rax' stores the reference to the array
	addq	%rdx, %rax										   # move the pointer by 'rdx' number of bytes.
	movl	(%rax), %eax									   # 'eax' gets the value (type cast)	
	cmpl	-32(%rbp), %eax									   # compare a[mid] with item
	jle	.L16												   # if a[mid] <= item, goto segment L16
	movl	-4(%rbp), %eax									   # 'eax' gets the value 'mid'
	subl	$1, %eax										   # subtract 'mid' by 1
	movl	%eax, -12(%rbp)									   # 'top' gets the value of 'eax' (mid-1)
	jmp	.L17												   # jump to section L17
	
.L16:														   # code segment L16 
	movl	-4(%rbp), %eax									   # 'eax' gets the value 'mid'
	cltq                      								   # convert to int64
	leaq	0(,%rax,4), %rdx								   # convert into bytes by multiplying by 4.
	movq	-24(%rbp), %rax									   # 'rax' gets the value of array pointer
	addq	%rdx, %rax										   # move the pointer by 'rdx' bytes 
	movl	(%rax), %eax									   # 'eax' gets the value of a[mid]
	cmpl	-32(%rbp), %eax									   # compare a[mid] with item
	jge	.L17												   # if a[mid] >= item, goto L17
	movl	-4(%rbp), %eax									   # 'eax' gets the value of 'mid'
	addl	$1, %eax										   # add 1 to 'eax'	
	movl	%eax, -8(%rbp)									   # bottom gets the value of 'eax' (mid+1)
	
.L17:														   # code segment L17
	movl	-4(%rbp), %eax									   # 'eax' gets the value of 'mid'
	cltq													   # converts to int64
	leaq	0(,%rax,4), %rdx								   # convert 'rax' into bytes and store in 'rdx'
	movq	-24(%rbp), %rax									   # 'rax' gets the reference to array 'a'
	addq	%rdx, %rax										   # shifts the pointer to 'rdx' bytes from array start
	movl	(%rax), %eax									   # 'eax' gets the value of 'rax'
	cmpl	-32(%rbp), %eax									   # compare a[mid] with item
	je	.L18												   # if equal (a[mid] == item), goto L18
	movl	-8(%rbp), %eax									   # 'eax' gets the value of 'bottom'
	cmpl	-12(%rbp), %eax								       # compare 'eax' with top (bottom and top)
	jle	.L19												   # if bottom <= top, goto L19
	
.L18:														   # code segment L18
	movl	-4(%rbp), %eax									   # 'eax' gets 'mid'
	popq	%rbp											   # pops the base pointer 'rbp'
	.cfi_def_cfa 7, 8
	ret														   # return 
	.cfi_endproc										       # end procedure
	
	
	
	
	
.LFE2:														   
	.size	bsearch, .-bsearch
	.globl	insert											   # global scope of 'insert'
	.type	insert, @function								   # function by the name 'insert'
insert:														   # insert begins here
.LFB3:	
	.cfi_startproc											   # start procedure
	pushq	%rbp											   # push the stack base pointer in stack
	.cfi_def_cfa_offset 16									   # set a absolute offset
	.cfi_offset 6, -16										   # Previous value of register is saved at offset -16 from CFA.
	movq	%rsp, %rbp										   # base pointer moves to stack pointer
	.cfi_def_cfa_register 6									   # modifies the rule for computing cfa.
	movq	%rdi, -24(%rbp)									   # first parameter (array 'a')
	movl	%esi, -28(%rbp)									   # second parameter ('n')
	movl	%edx, -32(%rbp)									   # third paramter ('item')
	movl	-28(%rbp), %eax									   # 'eax' gets the value of 'n'
	subl	$1, %eax										   # subtract 'eax' by 1
	movl	%eax, -4(%rbp)									   # 'i' gets assigned the value of 'n-1'
	jmp	.L22												   # unconditional jump to L22
	
.L24:														   # code segment L24
	movl	-4(%rbp), %eax									   # 'eax' gets the value of 'i'
	cltq													   # convert into int64
	addq	$1, %rax										   # 'rax' gets incremented by 1 (i -> i+1)
	leaq	0(,%rax,4), %rdx								   # convert into size in bytes (multiply by 4)
	movq	-24(%rbp), %rax									   # 'rax' gets the reference to array 'a'
	addq	%rax, %rdx										   # move the pointer by 'rdx' bytes
	movl	-4(%rbp), %eax									   # 'eax' gets the value of 'i'
	cltq													   # convert into int64
	leaq	0(,%rax,4), %rcx								   # convert into size in bytes (multiply by 4)
	movq	-24(%rbp), %rax									   # 'rax' gets the reference to array 'a'
	addq	%rcx, %rax										   # move the pointer by 'rdx' bytes
	movl	(%rax), %eax									   # 'eax' gets the value of 'rax' (64 to 32 bit)
	movl	%eax, (%rdx)									   # 'rdx' gets the value of 'eax' (num[i+1]=num[i])
	subl	$1, -4(%rbp)									   # subtract i by 1.
	
.L22:														   # code segment L22
	cmpl	$0, -4(%rbp)									   # compare i with 0
	js	.L23												   # if i is smaller than 0, jump to L23
	movl	-4(%rbp), %eax								       # 'eax' gets the value of 'i'
	cltq													   # convert into int64
	leaq	0(,%rax,4), %rdx								   # convert into bytes by multiplying by 4.
	movq	-24(%rbp), %rax									   # 'rax' gets the pointer to array 'a'
	addq	%rdx, %rax										   # shift the array pointer by 'rdx' bytes
	movl	(%rax), %eax									   # 'eax' gets the value of 'rax'
	cmpl	-32(%rbp), %eax									   # compares k and num[i]
	jg	.L24												   # if num[i] > k, goto L24
	
.L23:														   # code segment L23
	movl	-4(%rbp), %eax									   # 'eax' gets the value of 'i'
	cltq													   # convert into int64
	addq	$1, %rax										   # add 1 to 'rax'
	leaq	0(,%rax,4), %rdx								   # convert into size, in bytes, by multiplying by 4.
	movq	-24(%rbp), %rax									   # 'rax' gets the pointer to array 'a'
	addq	%rax, %rdx										   # move the pointer by 'rdx' bytes [4*(i+1)]
	movl	-32(%rbp), %eax									   # 'eax' now stores 'k'
	movl	%eax, (%rdx)									   # the value of 'k' gets assigned to a[i+1]
	movl	-4(%rbp), %eax									   # 'eax' now has 'i'
	addl	$1, %eax										   # increment i
	popq	%rbp											   # pop the stack base pointer
	.cfi_def_cfa 7, 8		
	ret														   # return 
	.cfi_endproc											   # end procedure
.LFE3:
	.size	insert, .-insert
	
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04.1) 4.8.4"       # specifications
	.section	.note.GNU-stack,"",@progbits
