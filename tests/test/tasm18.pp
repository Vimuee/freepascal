{ %CPU=i8086 }
program tasm18;

{$ifndef FPC}
type
  CodePointer = Pointer;
{$endif FPC}

const
  cval = 1;

type
  foo = record
    b1: byte;
    w: word;
    b2: byte;
  end;
  foo2 = record
    bb1, bb2: byte;
  end;

const
  expect1: array [0..$A9] of byte = (
    $F7,$05,$01,$00,      { TEST    WORD PTR [DI],0001    }
    $F6,$05,$01,          { TEST    BYTE PTR [DI],01      }
    $F7,$45,$01,$01,$00,  { TEST    WORD PTR [DI+01],0001 }
    $F6,$45,$03,$01,      { TEST    BYTE PTR [DI+03],01   }
    $F7,$45,$FF,$01,$00,  { TEST    WORD PTR [DI-01],0001 }
    $F6,$45,$FD,$01,      { TEST    BYTE PTR [DI-03],01   }
    $F7,$45,$04,$01,$00,  { TEST    WORD PTR [DI+04],0001 }
    $F6,$45,$04,$01,      { TEST    BYTE PTR [DI+04],01   }

    $F7,$05,$01,$00,      { TEST    WORD PTR [DI],0001    }
    $F6,$05,$01,          { TEST    BYTE PTR [DI],01      }
    $F7,$45,$01,$01,$00,  { TEST    WORD PTR [DI+01],0001 }
    $F6,$45,$03,$01,      { TEST    BYTE PTR [DI+03],01   }
    $F7,$45,$FF,$01,$00,  { TEST    WORD PTR [DI-01],0001 }
    $F6,$45,$FD,$01,      { TEST    BYTE PTR [DI-03],01   }
    $F7,$45,$04,$01,$00,  { TEST    WORD PTR [DI+04],0001 }
    $F6,$45,$04,$01,      { TEST    BYTE PTR [DI+04],01   }

    $F7,$05,$01,$00,      { TEST    WORD PTR [DI],0001    }
    $F6,$05,$01,          { TEST    BYTE PTR [DI],01      }
    $F7,$45,$05,$01,$00,  { TEST    WORD PTR [DI+05],0001 }
    $F6,$45,$0F,$01,      { TEST    BYTE PTR [DI+0F],01   }
    $F7,$45,$FB,$01,$00,  { TEST    WORD PTR [DI-05],0001 }
    $F6,$45,$F1,$01,      { TEST    BYTE PTR [DI-0F],01   }
    $F7,$45,$12,$01,$00,  { TEST    WORD PTR [DI+12],0001 }
    $F6,$45,$0E,$01,      { TEST    BYTE PTR [DI+0E],01   }

    $F6,$05,$01,          { TEST    BYTE PTR [DI],01      }
    $F6,$05,$01,          { TEST    BYTE PTR [DI],01      }
    $F6,$45,$01,$01,      { TEST    BYTE PTR [DI+01],01   }
    $F6,$45,$03,$01,      { TEST    BYTE PTR [DI+03],01   }
    $F6,$45,$FF,$01,      { TEST    BYTE PTR [DI-01],01   }
    $F6,$45,$FD,$01,      { TEST    BYTE PTR [DI-03],01   }
    $F6,$45,$04,$01,      { TEST    BYTE PTR [DI+04],01   }
    $F6,$45,$04,$01,      { TEST    BYTE PTR [DI+04],01   }

    $F7,$05,$01,$00,      { TEST    WORD PTR [DI],0001    }
    $F7,$05,$01,$00,      { TEST    WORD PTR [DI],0001    }
    $F7,$45,$01,$01,$00,  { TEST    WORD PTR [DI+01],0001 }
    $F7,$45,$03,$01,$00,  { TEST    WORD PTR [DI+03],0001 }
    $F7,$45,$FF,$01,$00,  { TEST    WORD PTR [DI-01],0001 }
    $F7,$45,$FD,$01,$00,  { TEST    WORD PTR [DI-03],0001 }
    $F7,$45,$04,$01,$00,  { TEST    WORD PTR [DI+04],0001 }
    $F7,$45,$04,$01,$00   { TEST    WORD PTR [DI+04],0001 }
  );


procedure test1; assembler; {$IFDEF FPC_MM_HUGE}nostackframe;{$ENDIF}
asm
  test [di+foo2], cval                   { test word ptr [di], 1   }
  test byte ptr [di+foo], cval           { test byte ptr [di], 1   }
  test [di+foo.w], cval                  { test word ptr [di+1], 1 }
  test [di+foo.b2], cval                 { test byte ptr [di+3], 1 }
  test [di-foo.w], cval                  { test word ptr [di-1], 1 }
  test [di-foo.b2], cval                 { test byte ptr [di-3], 1 }
  test [di+foo.b2+foo.w], cval           { test word ptr [di+4], 1 }
  test [di+foo.w+foo.b2], cval           { test byte ptr [di+4], 1 }

  test [di+foo2*1], cval                 { test word ptr [di], 1   }
  test byte ptr [di+foo*1], cval         { test byte ptr [di], 1   }
  test [di+foo.w*1], cval                { test word ptr [di+1], 1 }
  test [di+foo.b2*1], cval               { test byte ptr [di+3], 1 }
  test [di-foo.w*1], cval                { test word ptr [di-1], 1 }
  test [di-foo.b2*1], cval               { test byte ptr [di-3], 1 }
  test [di+foo.b2*1+foo.w*1], cval       { test word ptr [di+4], 1 }
  test [di+foo.w*1+foo.b2*1], cval       { test byte ptr [di+4], 1 }

  test [di+foo2*5], cval                 { test word ptr [di], 1    }
  test byte ptr [di+foo*5], cval         { test byte ptr [di], 1    }
  test [di+foo.w*5], cval                { test word ptr [di+5], 1  }
  test [di+foo.b2*5], cval               { test byte ptr [di+15], 1 }
  test [di-foo.w*5], cval                { test word ptr [di-5], 1  }
  test [di-foo.b2*5], cval               { test byte ptr [di-15], 1 }
  test [di+foo.b2*5+foo.w*3], cval       { test word ptr [di+18], 1 }
  test [di+foo.w*5+foo.b2*3], cval       { test byte ptr [di+14], 1 }

  test byte ptr [di+foo2], cval          { test byte ptr [di], 1   }
  test byte ptr [di+foo], cval           { test byte ptr [di], 1   }
  test byte ptr [di+foo.w], cval         { test byte ptr [di+1], 1 }
  test byte ptr [di+foo.b2], cval        { test byte ptr [di+3], 1 }
  test byte ptr [di-foo.w], cval         { test byte ptr [di-1], 1 }
  test byte ptr [di-foo.b2], cval        { test byte ptr [di-3], 1 }
  test byte ptr [di+foo.b2+foo.w], cval  { test byte ptr [di+4], 1 }
  test byte ptr [di+foo.w+foo.b2], cval  { test byte ptr [di+4], 1 }

  test word ptr [di+foo2], cval          { test word ptr [di], 1   }
  test word ptr [di+foo], cval           { test word ptr [di], 1   }
  test word ptr [di+foo.w], cval         { test word ptr [di+1], 1 }
  test word ptr [di+foo.b2], cval        { test word ptr [di+3], 1 }
  test word ptr [di-foo.w], cval         { test word ptr [di-1], 1 }
  test word ptr [di-foo.b2], cval        { test word ptr [di-3], 1 }
  test word ptr [di+foo.b2+foo.w], cval  { test word ptr [di+4], 1 }
  test word ptr [di+foo.w+foo.b2], cval  { test word ptr [di+4], 1 }
end;

procedure Error;
begin
  Writeln('Error!');
  Halt(1);
end;

{ This version works in all i8086 memory models }
function CompareCode(cp: CodePointer; dp: Pointer; sz: Integer): Boolean;
var
  I: Integer;
begin
  for I := 0 to sz - 1 do
    if Mem[Seg(cp^):Ofs(cp^) + I] <> Mem[Seg(dp^):Ofs(dp^) + I] then
    begin
      Writeln(I, ' ', Mem[Seg(cp^):Ofs(cp^) + I], ' ', Mem[Seg(dp^):Ofs(dp^) + I]);
      CompareCode := False;
      exit;
    end;
  CompareCode := True;
end;

begin
  if not CompareCode(CodePointer(@test1), @expect1, SizeOf(expect1)) then
    Error;

  Writeln('Ok!');
end.
