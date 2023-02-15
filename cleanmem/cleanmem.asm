    processor 6502
    
    seg code    
    org $F000           ; Define the code origin at $F000
    
Start: 
    sei                 ;Disable interrupts
    cld                 ;Disable the BCD decimal math mode
    ldx #$ff            ; loads the x register with #$ff
    txs                 ;tranfer the x register to the stack pointer
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;clear the page zero region ($00 to$FF)
    ;meaning the entire ram and also the entire TIA registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #0              ;A=0
    ldx #$FF            ;X = $ff
    
MemLoop:
;    txs                 ;tranfer the x register to the stack pointer
;    sta                 ;store zero at current memLoc
    sta $00,X            ;Store the value of A inside memory adress $00 + X 
    dex                  ;x--
    bne MemLoop          ;go to MemLoop if x != 0;
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Fill the ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    org $FFFC
    .word Start         ; Reset vector at $FFFC where the program stats
    .word Start         ;Interrupt vector at $FFFE(unused in the VCS/)
    