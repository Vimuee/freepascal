{
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by Michael Van Canneyt
    member of the Free Pascal development team

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

Unit ports;

{$inline on}

{ Implements the
     port[] portw[] and portl[]
  constructs using objects }

Interface

type
   tport = object
     protected
       procedure writeport(p : longint;data : byte);inline;
       function  readport(p : longint) : byte;inline;
     public
       property pp[w : longint] : byte read readport write writeport;default;
   end;

   tportw = object
     protected
       procedure writeport(p : longint;data : word);inline;
       function  readport(p : longint) : word;inline;
     public
       property pp[w : longint] : word read readport write writeport;default;
   end;

   tportl = object
     Protected
       procedure writeport(p : longint;data : longint);inline;
       function  readport(p : longint) : longint;inline;
     Public
      property pp[w : Longint] : longint read readport write writeport;default;
   end;


    { Non-Instantiaded vars. As yet, they don't have to be instantiated,
      because there is no need for 'self' etc. }

var
   port,
   portb : tport;
   portw : tportw;
   portl : tportl;


implementation

{$IFDEF VER3_0}
{ Bootstrapping kludge. Note that these do nothing, but since I/O ports are not
  necessary for bootstrapping, these are only added to make the rtl compile
  with 3.0.
}
procedure fpc_x86_outportb(p:longint;v:byte); begin end;
procedure fpc_x86_outportw(p:longint;v:word); begin end;
procedure fpc_x86_outportl(p:longint;v:longint); begin end;
function fpc_x86_inportb(p:word):byte; begin fpc_x86_inportb:=0; end;
function fpc_x86_inportw(p:word):word; begin fpc_x86_inportw:=0; end;
function fpc_x86_inportl(p:word):longint; begin fpc_x86_inportl:=0; end;
{$ENDIF VER3_0}

{ to give easy port access like tp with port[] }

procedure tport.writeport(p : Longint;data : byte);inline;

begin
  fpc_x86_outportb(p,data)
end;

function tport.readport(p : Longint) : byte;inline;

begin
  readport := fpc_x86_inportb(p);
end;

procedure tportw.writeport(p : longint;data : word);inline;

begin
  fpc_x86_outportw(p,data)
end;

function tportw.readport(p : longint) : word;inline;

begin
  readport := fpc_x86_inportw(p);
end;

procedure tportl.writeport(p : longint;data : longint);inline;

begin
  fpc_x86_outportl(p,data)
end;

function tportl.readport(p : longint) : longint;inline;

begin
  readPort := fpc_x86_inportl(p);
end;

end.
