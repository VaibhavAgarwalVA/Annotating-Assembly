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
	movq	%rsp, %rbp										   # changes the base pointer. adjust the stack top pointer.
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
	
.L7:
	movl	-408(%rbp), %eax
	cltq
	movl	-400(%rbp,%rax,4), %eax
	movl	%eax, %esi
	movl	$.LC7, %edi
	movl	$0, %eax
	call	printf
	addl	$1, -408(%rbp)
.L6:
	movl	-416(%rbp), %eax
	cmpl	%eax, -408(%rbp)
	jl	.L7
	movl	$10, %edi
	call	putchar
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	inst_sort
	.type	inst_sort, @function
inst_sort:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	$1, -8(%rbp)
	jmp	.L10
.L14:
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -4(%rbp)
	movl	-8(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.L11
.L13:
	movl	-12(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %eax
	movl	%eax, (%rdx)
	subl	$1, -12(%rbp)
.L11:
	cmpl	$0, -12(%rbp)
	js	.L12
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	-4(%rbp), %eax
	jg	.L13
.L12:
	movl	-12(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	movl	%eax, (%rdx)
	addl	$1, -8(%rbp)
.L10:
	movl	-8(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L14
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	inst_sort, .-inst_sort
	.globl	bsearch
	.type	bsearch, @function
bsearch:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	movl	$1, -8(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -12(%rbp)
.L19:
	movl	-12(%rbp), %eax
	movl	-8(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	-32(%rbp), %eax
	jle	.L16
	movl	-4(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.L17
.L16:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	-32(%rbp), %eax
	jge	.L17
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
.L17:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	-32(%rbp), %eax
	je	.L18
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jle	.L19
.L18:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	bsearch, .-bsearch
	.globl	insert
	.type	insert, @function
insert:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	movl	-28(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.L22
.L24:
	movl	-4(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %eax
	movl	%eax, (%rdx)
	subl	$1, -4(%rbp)
.L22:
	cmpl	$0, -4(%rbp)
	js	.L23
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	-32(%rbp), %eax
	jg	.L24
.L23:
	movl	-4(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-32(%rbp), %eax
	movl	%eax, (%rdx)
	movl	-4(%rbp), %eax
	addl	$1, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	insert, .-insert
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04.1) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
