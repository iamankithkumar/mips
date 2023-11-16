.text
 
main: 
li ax,'8'
sub ax, '0'
mov bl, '2'
sub bl, '0'
div bl
add ax, '0'
li res, ax
li ecx,msg
li edx, len
li ebx,1 
li eax,4 
int 0x80 
nwln
li ecx,res
li edx, 1
li ebx,1 
li eax,4 
int 0x80 
li eax,1 
int 0x80 
section .data
msg db "The result is:", 0xA,0xD
len equ $- msg
segment .bss
res resb 1