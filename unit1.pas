unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Math;

type
  TMotionLabel=class(TLabel)
  public
    dirx: integer;
    diry: integer;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label19: TLabel;
    Label25: TLabel;
    Label43: TLabel;
    label44: TLabel;
    d2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label3: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape9: TShape;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    d: TMotionLabel;
    procedure updatelabel;
    Procedure ProcessLists;
  end;


var
  Form1: TForm1;
  n, k: integer;
  numa, numc, numcp: integer;
  obja, objc, objcp: TList;
  andely: integer;
  combtol: integer;
  curAs, curCs, curCPs: integer;
  currentstep: integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.UpdateLabel;
begin
  label6.caption := inttostr(obja.count) + ' a''s, '
    + inttostr(objc.count) + ' c''s, '
    + inttostr(objcp.count) + ' c prime''s';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  randomize;

  panel3.color := shape2.brush.color;
  panel11.color := shape2.brush.color;
  panel12.color := shape1.brush.color;
  shape4.hide;
  shape5.hide;

  d := TMotionLabel.Create(Panel3);
  d.parent := Panel3;
  d.font.name := 'Cambria';
  d.font.style := [fsitalic];
  d.caption := 'd';
  d.Left:=random(panel3.width-d.width*5)+d.width*2;
  d.Top:=random(panel3.height-d.height*5)+d.height*2;
  d.hide;
  d.color := d2.color;

  label19.color := label39.color;
  label25.color := label39.color;
  label48.color := label39.color;
  label5.color := label39.color;
  label10.color := label41.color;
  label17.color := label41.color;
  label43.color := label41.color;
  label11.color := label44.color;
  label13.color := label44.color;
  label33.color := label44.color;
  label18.color := d2.color;
  label21.color := d2.color;
  label46.color := d2.color;
  label23.color := d2.color;

  label6.hide;
  currentstep := 0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if combtol < 10 then
    combtol := combtol + 2
  else
  if combtol < 20 then
    combtol := combtol + 5
  else
    combtol := combtol + 10;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  shape4.show;
  objc.AddList(objcp);
  objcp.clear;
  ProcessLists;
  shape4.hide;
end;

procedure TForm1.ProcessLists;
var
  a, c: TMotionLabel;
  i, j: integer;
  showmotion: boolean;
  availableAs, availableCs: boolean;

  procedure MoveLabel(lb:TMotionLabel);
  begin
    lb.left := lb.left + lb.dirx;
    lb.top := lb.Top + lb.diry;
    if (lb.left < 0) and (lb.dirx < 0) then
    begin
      lb.dirx := -lb.dirx;
      lb.left := 0;
    end;
    if (lb.left > panel3.width-lb.width) and (lb.dirx > 0) then
    begin
      lb.dirx := -lb.dirx;
      lb.Left:=lb.left + lb.dirx;
    end;
    if (lb.top < 0) and (lb.diry < 0) then
    begin
      lb.diry := -lb.diry;
      lb.top := 0;
    end;
    if (lb.top > panel3.height-lb.height) and (lb.diry > 0) then
    begin
      lb.diry := -lb.diry;
      lb.top:=lb.top + lb.diry;
    end;

  end;

begin
  currentstep := currentstep + 1;
  label6.caption := 'Step: ' + inttostr(currentstep);

  combtol := 1;
  timer1.enabled := true;

  beginformupdate;
  panel13.hide;
  d.show;
  if obja.count > 0 then
    for i := 0 to obja.count-1 do
      TMotionLabel(obja.items[i]).Show;
  if objc.count > 0 then
    for i := 0 to objc.count-1 do
      TMotionLabel(objc.items[i]).Show;
  if objcp.count > 0 then
    for i := 0 to objcp.count-1 do
      TMotionLabel(objcp.items[i]).Show;
  endformupdate;

  showmotion := true;

  while showmotion do
  begin
    if (obja.count=0) or (objc.count=0) then
      break;

    BeginFormUpdate;
    DisableAlign;

    MoveLabel(d);

    for i := 0 to objc.count-1 do
    begin
      if obja.count <= i then
        break;

      a := TMotionLabel(obja.items[i]);
      c := TMotionLabel(Objc.items[i]);

      if c.tag = 0 then
      begin
        if a.left > c.left then
        begin
          a.left := a.left - 1;
          if c.left <> a.left then
            c.left := c.Left + 1;
        end
        else
        if a.left <> c.left then
        begin
          a.left := a.left + 1;
          if c.left <> a.left then
            c.left := c.left - 1;
        end;

        if a.top > c.top then
        begin
          a.top := a.top - 1;
          if c.top <> a.top then
            c.top := c.top + 1;
        end
        else
        if a.top <> c.top then
        begin
          a.top := a.top + 1;
          if c.top <> a.top then
            c.top := c.top - 1;
        end;
      end;
    end;

    if obja.count > objc.count then
      for i := objc.Count to obja.count - 1 do
        MoveLabel(TMotionLabel(obja.items[i]));

    if objc.count > obja.count then
      for i := obja.count to objc.count-1 do
        MoveLabel(TMotionLabel(objc.items[i]));

    if objcp.count> 0 then
      for i := 0 to objcp.count-01 do
        MoveLabel(TMotionLabel(objcp.items[i]));

    for i := 0 to objc.count - 1 do
    begin
      if obja.count <= i then
        break;

      a := TMotionlabel(obja.items[i]);
      c := tmotionlabel(objc.items[i]);
      if (a.left = c.left) and (a.top = c.top) and (c.tag = 0) then
      begin
        a.tag := 1;
        a.hide;
        c.tag := 1;
        //c.font.color := clwhite;
        if c.caption = 'c ' then
        begin
          c.caption := 'c''';
          c.Color := label44.color;;
        end
        else
        begin
          c.caption := 'c ';
          c.color := label41.color;
        end;
        c.SendToBack;
        //updatelabel;
      end
      else
      if c.tag = 1 then
        MoveLabel(c);
    end;

    EnableAlign;
    EndFormUpdate;

    application.ProcessMessages;
    sleep(1); //sleep(andely);

    //updatelabel;

    availableAs := false;
    availableCs := false;
    for i := 0 to obja.count - 1 do
      if TMotionLabel(obja.items[i]).tag = 0 then
        availableAs := true;
    if Showmotion = true then
    for i := 0 to objc.count - 1 do
      if TMotionLabel(objc.items[i]).tag = 0 then
        availableCs := true;
    Showmotion := availableAs and availableCs;
  end;

  for i := obja.count-1 downto 0 do
  begin
    a := TMotionLabel(obja.items[i]);
    if a.tag = 1 then
    begin
      obja.Delete(i);
      a.free;
    end;
  end;

  //UpdateLabel;

  for i := objc.count-1 downto 0 do
  begin
    c := TMotionLabel(objc.items[i]);
    if c.tag = 1 then
    begin
      c.tag := 0;
      objc.delete(i);
      objcp.add(c);
    end;
  end;

  application.processmessages;
  sleep(3000);

  {
  beginformupdate;


  if objcp.count > 0 then
    for i := 0 to objcp.count-1 do
    begin
      tmotionlabel(objcp.items[i]).Transparent := true;
      tmotionlabel(objcp.items[i]).font.color := clBlack;
    end;

  endformupdate;
  }

  beginformupdate;
  d.hide;
  if obja.count > 0 then
    for i := 0 to obja.count-1 do
      TMotionLabel(obja.items[i]).hide;
  if objc.count > 0 then
    for i := 0 to objc.count-1 do
      TMotionLabel(objc.items[i]).hide;
  if objcp.count > 0 then
    for i := 0 to objcp.count-1 do
      TMotionLabel(objcp.items[i]).hide;
  endformupdate;

  curAs := obja.count;
  curCs := 0;
  curCPs := 0;
  if objc.count > 0 then
    for i := 0 to objc.count-1 do
      if TMotionLabel(objc.items[i]).caption = 'c ' then
        curCs := curCs +1
      else
        curCPs := curCPs + 1;
  if objcp.count > 0 then
    for i := 0 to objcp.count-1 do
      if TMotionLabel(objcp.items[i]).caption = 'c ' then
        curCs := curCs + 1
      else
        curCPs := curCPs + 1;

  panel13.show;
  disablealign;
  label39.visible := curAs > 0;
  label40.visible := curAs > 0;
  label40.caption := inttostr(curAs);
  label41.visible := curCs > 0;
  label42.visible := curCs > 0;
  label42.caption := inttostr(curCs);
  label44.visible := curCPs > 0;
  label45.visible := curCPs > 0;
  label45.caption := inttostr(curCPs);
  label39.left := 0;
  label40.left := 1;
  label41.left := 2;
  label42.left := 3;
  label44.left := 4;
  label45.left := 5;
  d2.left := 6;
  enablealign;
  timer1.enabled := false;

end;
procedure TForm1.Button2Click(Sender: TObject);
begin
  shape5.show;
  objc.AddList(objcp);
  objcp.clear;
  ProcessLists;
  shape5.hide;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  rinc, ginc, binc: integer;
  r1, g1, b1: byte;
  r2, g2, b2: byte;
  i: integer;
  curCs, curCPs: integer;

  procedure fadecolor;
  begin
    RedGreenBlue(Shape2.Brush.Color, r2, g2, b2);
    r2 := r2 + rinc;
    g2 := g2 + ginc;
    b2 := b2 + binc;
    Shape2.Brush.Color:=RgbToColor(r2, g2, b2);
    Panel3.Color := Shape2.Brush.Color;
    Panel11.Color := Panel3.Color;
  end;

begin
  currentstep := currentstep + 1;
  label6.caption := 'Step: ' + inttostr(currentstep);

  shape6.show;

  beginformupdate;
  panel13.hide;
  d.show;
  if obja.count > 0 then
    for i := 0 to obja.count-1 do
      TMotionLabel(obja.items[i]).Show;
  if objc.count > 0 then
    for i := 0 to objc.count-1 do
      TMotionLabel(objc.items[i]).Show;
  if objcp.count > 0 then
    for i := 0 to objcp.count-1 do
      TMotionLabel(objcp.items[i]).Show;
  endformupdate;

  d.bringtofront;
  application.processmessages;
  sleep(500);
  for i := 1 to 3 do
  begin
    d.hide;
    application.processmessages;
    sleep(500);
    d.Show;
    application.processmessages;
    sleep(500);
  end;


  RedGreenBlue(Shape1.Brush.Color, r1, g1, b1);
  RedGreenBlue(Shape2.Brush.Color, r2, g2, b2);

  rinc := (r1-r2) div 10;
  ginc := (g1-g2) div 10;
  binc := (b1-b2) div 10;

  for i := 1 to 10 do
  begin
    fadecolor;
    application.processmessages;
    sleep(200);
  end;

  beginformupdate;
  panel13.show;
  d.hide;
  if obja.count > 0 then
    for i := 0 to obja.count-1 do
      TMotionLabel(obja.items[i]).hide;
  if objc.count > 0 then
    for i := 0 to objc.count-1 do
      TMotionLabel(objc.items[i]).hide;
  if objcp.count > 0 then
    for i := 0 to objcp.count-1 do
      TMotionLabel(objcp.items[i]).hide;
  endformupdate;

  shape2.hide;
  panel11.hide;
  label2.hide;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  i: integer;
  l1, l2: TMotionLabel;
begin
  currentstep := currentstep + 1;
  label6.caption := 'Step: ' + inttostr(currentstep);

  beginformupdate;
  panel13.hide;
  d.show;
  d.bringtofront;
  if obja.count > 0 then
    for i := 0 to obja.count-1 do
      TMotionLabel(obja.items[i]).Show;
  if objc.count > 0 then
    for i := 0 to objc.count-1 do
      TMotionLabel(objc.items[i]).Show;
  if objcp.count > 0 then
    for i := 0 to objcp.count-1 do
      TMotionLabel(objcp.items[i]).Show;
  endformupdate;

  if objc.count > 0 then
  begin
    l1 := tmotionlabel(objc.items[0]);
    objc.delete(0);
  end
  else
    l1 := nil;
  if objcp.count > 0 then
  begin
    l2 := tmotionlabel(objcp.items[0]);
    objcp.delete(0);
  end
  else
    l2 := nil;

  if l1 <> nil then l1.bringtofront;
  if l2 <> nil then l2.bringtofront;

  if (l1 <> nil) and (l2 <> nil) then
  begin
    shape9.show;
  end;

  for i := 1 to 5 do
  begin
    d.hide;
    if l1 <> nil then l1.hide;
    if l2 <> nil then l2.hide;
    application.processmessages;
    sleep(500);
    d.show;
    if l1 <> nil then l1.show;
    if l2 <> nil then l2.show;
    application.processmessages;
    sleep(500);
  end;

  if (l1 <> nil) and (l2 <> nil) then
  begin
    shape9.show;

    application.processmessages;
    sleep(1000);

    l1.hide;
    l2.hide;

    panel15.Left:=panel3.left+d.left;
    panel15.top := panel3.top + d.top;
    d.caption := 'a';
    d.color := label39.color;
    d.font.size := label5.font.size;
    d.parent := panel15;
    d.Left :=0;
    d.top := 0;

    panel15.show;
    panel15.top := label5.top;
    application.processmessages;

    for i := panel15.Left to label5.left do
    begin
      panel15.left := i;
      application.processmessages;
      sleep(10);
    end;
    panel15.hide;
    label5.caption := 'aa';
  end;

  for i := 1 to 5 do
  begin
    label5.hide;
    application.processmessages;
    sleep(500);
    label5.show;
    application.processmessages;
    sleep(500);
  end;

  beginformupdate;
  d.hide;
  if l1 <> nil then
    l1.hide;
  if l2 <> nil then
    l2.hide;
  if obja.count > 0 then
    for i := 0 to obja.count-1 do
      TMotionLabel(obja.items[i]).hide;
  if objc.count > 0 then
    for i := 0 to objc.count-1 do
      TMotionLabel(objc.items[i]).hide;
  if objcp.count > 0 then
    for i := 0 to objcp.count-1 do
      TMotionLabel(objcp.items[i]).hide;
  endformupdate;

  curCs := 0;
  curCPs := 0;
  if objc.count > 0 then
    for i := 0 to objc.count-1 do
      if TMotionLabel(objc.items[i]).caption = 'c ' then
        curCs := curCs +1
      else
        curCPs := curCPs + 1;
  if objcp.count > 0 then
    for i := 0 to objcp.count-1 do
      if TMotionLabel(objcp.items[i]).caption = 'c ' then
        curCs := curCs + 1
      else
        curCPs := curCPs + 1;

  panel13.show;
  disablealign;
  label39.visible := false;
  label40.visible := false;
  label41.visible := curCs > 0;
  label42.visible := curCs > 0;
  label42.caption := inttostr(curCs);
  label44.visible := curCPs > 0;
  label45.visible := curCPs > 0;
  label45.caption := inttostr(curCPs);
  label39.left := 0;
  label40.left := 1;
  label41.left := 2;
  label42.left := 3;
  label44.left := 4;
  label45.left := 5;
  d2.hide;
  enablealign;

  shape9.hide;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  l, l2: TmotionLabel;
  i: integer;
  fsz: integer;

  procedure AssignMotionDir(lb: TMotionLabel);
  begin
    lb.dirx := random(5)-2;
    lb.diry := random(5)-2;
    if (lb.dirx = 0) and (lb.diry = 0) then
      AssignMotionDir(lb);
  end;

begin
  label6.Caption := 'Initial Configuration';
  label6.show;

  panel14.hide;
  label40.Caption := edit1.text;
  label42.caption := edit2.text;

  application.processmessages;

  sleep(5000);

  panel13.hide;

  n := strtointdef(edit1.text, 1); //870; //357;
  k := strtointdef(edit2.text, 1); //174; //45;

  if (n+k)<100 then
    andely := 100
  else if (n+k) <200 then
    andely :=50
  else if (n+k)<400 then
    andely :=20
  else
    andely :=1;

  fsz := 20-((n+k) div 100);
  if fsz < 8 then
    fsz := 8;

  numa := n;
  numc := k;
  numcp := 0;



  obja := TList.Create;
  objc := TList.Create;
  objcp := TList.Create;

  beginformupdate;

  for i := 1 to n do
  begin
    l := TMotionLabel.Create(Panel3);
    l.parent := Panel3;
    l.color := label39.color;
    l.font.name := 'Cambria';
    l.font.size := fsz;
    l.font.style := [fsitalic];
    l.caption := 'a';
    l.Left:=random(panel3.width-20);
    l.Top:=random(panel3.height-20);
    AssignMotionDir(l);
    obja.Add(l);

  end;

  for i := 1 to k do
  begin
    l := TMotionLabel.Create(Panel3);
    l.parent := Panel3;
    l.color := label41.color;
    l.font.name := 'Cambria';
    l.font.size := fsz;
    l.font.style := [fsitalic];
    l.caption := 'c ';
    l.Left:=random(panel3.width-20);
    l.Top:=random(panel3.height-20);
    if obja.Count >= i then
    begin
      l2 := TMotionLabel(obja.Items[i]);
      l.Left := l2.Left + random(l2.width*5)-l2.width*2;
      l.top := l2.top + random(l2.height*5)-l2.height*2;
    end;
    l.AdjustSize;
    AssignMotionDir(l);
    objc.Add(l);
  end;

  d.font.size := fsz;
  AssignMotionDir(d);
  d.Show;

  endformupdate;

  //updatelabel;

end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  application.Terminate;
end;

end.

