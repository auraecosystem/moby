section .text
global aura_transform_buffer_abi

; C-ABI Signature: void aura_transform_buffer_abi(const char* input, char* output, uint64_t len)
aura_transform_buffer_abi:
    ; Input pointer in rdi, Output pointer in rsi, Length in rdx
    test rdx, rdx
    jz .done
.loop:
    mov al, [rdi]
    ; perform low-overhead optimization or character encoding transformation
    mov [rsi], al
    inc rdi
    inc rsi
    dec rdx
    jnz .loop
.done:
    ret
