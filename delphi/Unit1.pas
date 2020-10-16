unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, Math;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    RichEdit1: TRichEdit;
    RichEdit2: TRichEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ListBox1: TListBox;
    Button2: TButton;
    Chart1: TChart;
    Frame1Series: TLineSeries;
    Frame2Series: TLineSeries;
    Frame3Series: TLineSeries;
    Chart2: TChart;
    Aseries: TLineSeries;
    Gseries: TLineSeries;
    Cseries: TLineSeries;
    Tseries: TLineSeries;
    Chart3: TChart;
    Button3: TButton;
    Label2: TLabel;
    Edit1: TEdit;
    TabSheet2: TTabSheet;
    Button4: TButton;
    ATSeries: TFastLineSeries;
    GCSeries: TFastLineSeries;
    Label3: TLabel;
    Button5: TButton;
    ComboBox1: TComboBox;
    ListBox2: TListBox;
    Button6: TButton;
    Button7: TButton;
    DNAw: TEdit;
    DNAv: TEdit;
    buttonLCS: TButton;
    Memo1: TMemo;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    RemovingIntron: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    CheckBox1: TCheckBox;
    Chart4: TChart;
    Series1: TLineSeries;
    TabSheet3: TTabSheet;
    ListBox3: TListBox;
    Edit5: TEdit;
    ListBox4: TListBox;
    Button9: TButton;
    Chart5: TChart;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Button8: TButton;
    Series4: TLineSeries;
    TabSheet4: TTabSheet;
    Button10: TButton;
    Edit6: TEdit;
    Edit7: TEdit;
    ListBox5: TListBox;
    Button11: TButton;
    Memo2: TMemo;
    Memo3: TMemo;
    Chart6: TChart;
    Series5: TLineSeries;
    Series6: TLineSeries;
    Series7: TLineSeries;
    Series8: TLineSeries;
    Button12: TButton;
    Series9: TLineSeries;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    Label18: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Timer1: TTimer;
    Timer2: TTimer;
    Edit11: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Button13: TButton;
    ComboBox2: TComboBox;
    Edit20: TEdit;
    Edit21: TEdit;
    TabSheet5: TTabSheet;
    Button14: TButton;
    Memo4: TMemo;
    Memo5: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure findORF(frame : integer);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    Procedure openORF(index : integer);
    function translate(s : string):string;
    function copyORF(index : integer):string;
    function LCS(v,w : string):real;
    function maxx(a,b,c : integer;trig : boolean):integer;
    Function mynt(ch :char):integer;
    function nuct(s : char):integer;
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure buttonLCSClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button14Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FileName : string;
  BanyakORF,totalBP,iter : int64;
  orfl : array[1..3,1..10000]of integer;
  maxORF : integer;
  saving : TStringList;
  scoring,direction : array[0..10000,0..10000] of integer;
  nnA,nnG,nnC,nnT : array[0..1] of int64;
  atrich,gcrich : integer;
  Tbef,ATAT, ATGC, GCAT, GCGC : integer;
  RichState : array[1..2000000]of integer;
  n : array [1..6,0..1] of integer;            {+++++}
  p : array[1..14,0..2000000]of extended;
  path : array[1..14,0..2000000]of integer;
  transition : array[1..14,1..14]of extended ;
  emission : array[1..4,1..14] of real;
  TransVal : array[1..14] of real;
  transValORF : string;
const
  minL = 6; //Minimum ORF length

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  txtFile : TextFile;
  temp : string;
  nt : char;
  numA, numG, numC, numT,i : int64;
begin
  //  clearing series
  frame1series.Clear;
  frame2series.Clear;
  frame3series.Clear;
  Aseries.Clear;
  Gseries.Clear;
  Cseries.Clear;
  Tseries.Clear;

  //conditioning
  banyakORF := 0;
  listbox1.Clear;
  richedit1.Clear;
  richedit2.Clear;
  numA := 0;
  numG := 0;
  numC := 0;
  numT := 0;

  //  Target file
  if opendialog1.Execute then fileName := opendialog1.FileName;
  label1.Caption := fileName;

  //  Pembuatan file .dat untuk menyimpan hasil ORF
  temp := fileName;
  delete(temp,length(temp)-3,4);
  temp := temp + '.dat';
  label3.Caption := temp;
  temp := '';

  //  Buka textfile
  assignFile(txtFile,fileName);
  reset(txtFile);
  //  eliminasi Header
  readln(txtFile,temp);
  richedit2.Text := temp;
  //  Content
  i := 1;
  while not eof(txtFile) do begin
    read(txtFile,nt);
    //if not newline/enter
    if(nt <> chr(10))AND(nt <> chr(13)) then begin
      //  count each nucleotide
      if(nt = 'A') then inc(numA);
      if(nt = 'G') then inc(numG);
      if(nt = 'C') then inc(numC);
      if(nt = 'T') then inc(numT);

      //  if false detect
      if (nt <>'A')AND(nt <> 'G')AND(nt <> 'C')AND(nt <> 'T') then richedit1.SelAttributes.Color := clRed;
      //richedit1.SelText := nt;
      //richedit1.SelAttributes.Color := clWindowText;
      inc(i);
    end;
  end;

  i := i-2;
  totalBP := i;
  listbox1.Items.Add('Total bp : '+inttostr(i)+' '+inttostr(numA+numT+numC+numG));
  listbox1.Items.add('');
  listbox1.Items.add('Frekuensi A : '+floattostr(numA/totalBP));
  listbox1.Items.add('Frekuensi G : '+floattostr(numG/totalBP));
  listbox1.Items.add('Frekuensi C : '+floattostr(numC/totalBP));
  listbox1.Items.add('Frekuensi T : '+floattostr(numT/totalBP));


  closefile(txtFile);
end;

procedure TForm1.findORF(frame : integer);
var
  myFile : textFile;
  temp : string;
  nt : char;
  codon: string;
  i,startPos, StopPos : int64;
  startbool : boolean;
  max : integer;
begin
  //  Inisialisasi
  startBool := false;

  //  Buka textfile
  assignFile(myFIle,fileName);
  reset(myFile);

  //  Eliminasi Header
  readln(myFile,temp);

  //  Pemilihan Frame
  if(frame = 2) then begin i:=2;read(myFile,nt);end
  else if (frame = 3) then begin read(myFile,nt);read(myFile,nt);i := 3;end
  else i := 1;

  codon := '';
  max := 0;
  while i<= totalBP do begin
    //  take 3 nt for 1 codon
    while (length(codon) < 3) do begin
      read(myFile,nt);
      if(nt <> chr(10))and(nt <> chr(13)) then begin
        codon := codon + nt;
        inc(i);
      end;
    end;
    //  listbox1.Items.add(inttostr(i-3)+' '+codon[1]);
    //  Pakai codon untuk Frame1
    //  Catat start pertama pakai boolean StartBool
    //  Start pertama akan bertemu stop pertama kalau StartBool TRUE
    //  dan ketemu kodon STOP
    if(codon = 'ATG')and(not StartBool) then begin
      StartPos := i-3;
      startBool := true;
    end
    else if ((codon = 'TAA')or(codon = 'TAG')or(codon = 'TGA'))and(startBool) then begin
      stopPos := i-1;
      //if (stopPos - startPos +1) > MINL then listbox1.Items.add(inttostr(startPos)+' '+inttostr(stopPos));

      //  counting data per frame
      if (stopPos - startPos +1) > MINL then begin
        inc(orfl[frame,stopPos - StartPos+1]);
        // saving using stringlist
        saving.Add(inttostr(startPos)+chr(9)+inttostr(stopPos)+chr(9)+inttostr(frame));
      end;
      //find max
      if (StopPos - StartPos +1) > max then max := StopPos - StartPos +1;
      inc(BanyakORF);
      startBool := False;
    end;
    codon := '';
  end;
  closeFile(myFIle);
  maxORF := max;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i : integer;
begin
  saving := TStringList.Create;
  findORF(1);
  for i := 1 to maxORF do frame1Series.AddXY(i,orfl[1,i]);
  findORF(2);
  for i := 1 to maxORF do frame2Series.AddXY(i,orfl[2,i]);
  findORF(3);
  for i := 1 to maxORF do frame3Series.AddXY(i,orfl[3,i]);
  //saving.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Aseries.Clear;
  Gseries.Clear;
  Cseries.Clear;
  Tseries.Clear;
  ATSeries.Clear;
  GCSeries.Clear;
  iter := 1;
  atRich := 0;
  gcRich := 0;
  for iter := 0 to 1 do begin
    nnA[iter] := 0;
    nnC[iter] := 0;
    nnG[iter] := 0;
    nnT[iter] := 0;
  end;
  ATAT := 0;
  ATGC := 0;
  GCAT := 0;
  GCGC := 0;
  timer1.Enabled := TRUE;

  //i:=1;
  //while (i <= 10000) do begin
    //  open FIle
    //  File Management
    //assignFile(myFile,FileName);
    //reset(MyFile);
    //readln(myFile,temp); // keluarkan header
    //inisiasi
    // inisialisasi
    //nA := 0;
    //ng := 0;
    //nc := 0;
    //nt := 0;
    //  cari start penghitungan i
    //j := 1;
    //while (j < i) do begin read(myFile,ch);inc(j);end;
    //  Hitung densitas AGCT
    //j := 1;
    //while (j < k) do begin
      //read(myFile,ch);
      //if (ch = 'A') then inc(nA);
      //if (ch = 'G') then inc(nG);
      //if (ch = 'C') then inc(nC);
      //if (ch = 'T') then inc(nT);
      //inc(j);
    //end;

    //Aseries.AddXY(i,nA/k);
    //Gseries.AddXY(i,nG/k);
    //Cseries.AddXY(i,nC/k);
    //Tseries.AddXY(i,nT/k);
    //inc(i);
    //closeFile(myFile);
  //end;


end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  k : int64;
  nA,nG,nC,nT,nAT,nGC,j : integer;
  myFile : textFile;
  temp : string;
  dimer : string;
  ch,chBef : char;
  GTStart, AGend : string;
  total : integer;

begin
    k := strtoint(edit1.Text);
    //  open FIle
    //  File Management
    dimer := '';
    assignFile(myFile,FileName);
    reset(MyFile);
    readln(myFile,temp); // keluarkan header
    //inisiasi
    // inisialisasi
    nA := 0;
    ng := 0;
    nc := 0;
    nt := 0;
    nAT := 0;
    nGC := 0;
    //  cari start penghitungan i
    j := 1;
    while (j < iter) do begin read(myFile,ch);inc(j);end;
    //  Hitung densitas AGCT
    j := 1;
    while (j < k) do begin
      read(myFile,ch);
      //-------------------------finding Intron------------------------
   { if removingIntron.Checked then
      if (ch = 'G') then GTstart := GTstart + 'G'
      else if (GTStart = 'G')and(ch = 'T')then begin
        //delete the latest char that contain
        //splicing
        AGend := '';
        temp := '';
        while (AGend <> 'AG') do begi
          read(myFile,ch);
          if (ch <> chr(13))And(ch <>chr(10)) then inc(j);

          temp := temp+ch;
          if ch = 'A' then AGend := AGend + 'A'
          else if (AGend = 'A')and (ch = 'G') then begin
            AGend := 'AG';
            read(myfile,ch);
            if (ch <> chr(13))And(ch <>chr(10)) then inc(j);
          end
          else if eof(myFile) then begin
            break;
          end
          else AGend := '';
        end;

        GTstart := '';
      end
      else GTstart :='';}
    //-------------------------------end of Detecting Intron------------------------
      if(chBef = 'A') and (ch = 'T') then inc(nAT);
      if(chBef = 'G') and (ch = 'C') then inc(nGC);
      if (ch = 'A') then inc(nA);
      if (ch = 'G') then inc(nG);
      if (ch = 'C') then inc(nC);
      if (ch = 'T') then inc(nT);
      chBef := ch;
      inc(j);
    end;
    // Hai
    Aseries.AddXY(iter,nA/k);
    Gseries.AddXY(iter,nG/k);
    Cseries.AddXY(iter,nC/k);
    Tseries.AddXY(iter,nT/k);
    ATSeries.AddXY(iter,nAT/k);
    GCSeries.AddXY(iter,nGC/k);
    closeFile(myFile);
    if (nAT/k)>(nGC/k) then begin
      nnA[0] := nnA[0]+nA;
      nnC[0] := nnC[0]+nC;
      nnG[0] := nnG[0]+nG;
      nnT[0] := nnT[0]+nT;
    end
    else begin
      nnA[1] := nnA[1]+nA;
      nnC[1] := nnC[1]+nC;
      nnG[1] := nnG[1]+nG;
      nnT[1] := nnT[1]+nT;
    end;

    //Switching
    //0 for AT, 1 for GC
    if (iter = 1) then begin
      if (nAT/k)>(nGC/k) then Tbef := 0 else Tbef := 1;
    end
    else begin
      if (Tbef = 0 ) and ((nAT/k)>(nGC/k)) then inc (ATAT);
      if (Tbef = 1 ) and ((nAT/k)>(nGC/k)) then inc (GCAT);
      if (Tbef = 0 ) and ((nAT/k)<(nGC/k)) then inc (ATGC);
      if (Tbef = 1 ) and ((nAT/k)<(nGC/k)) then inc (GCGC);

      if ((nAT/k)>(nGC/k)) then Tbef := 0
      else if (nAT/k)<(nGC/k) then Tbef := 1
      else tbef := tbef;

      // Plotting
      listbox4.Clear;
      listbox4.Items.Add('AT Rich');
      total := nnA[0] + nnC[0] + nnG[0] + nnT[0];
      if total <> 0 then begin
        listbox4.Items.add('A ' + floattostr(nnA[0]/total));
        listbox4.Items.add('G ' + floattostr(nnG[0]/total));
        listbox4.Items.add('C ' + floattostr(nnC[0]/total));
        listbox4.Items.add('T ' + floattostr(nnT[0]/total));
      end;
      
      listbox4.Items.Add('GT Rich');
      total := nnA[1] + nnC[1] + nnG[1] + nnT[1];
      if (total <> 0) then begin
        listbox4.Items.add('A ' + floattostr(nnA[1]/total));
        listbox4.Items.add('G ' + floattostr(nnG[1]/total));
        listbox4.Items.add('C ' + floattostr(nnC[1]/total));
        listbox4.Items.add('T ' + floattostr(nnT[1]/total));
      end;
      
      total := ATAT+ ATGC + GCAT + GCGC;
      listbox4.Items.Add('Transisional Value');
      if (total <> 0) then begin
        listbox4.Items.add('AT-AT : '+floattostr(ATAT/total));
        listbox4.Items.add('AT-GC : '+floattostr(ATGC/total));
        listbox4.Items.add('GC-AT : '+floattostr(GCAT/total));
        listbox4.Items.add('GC-GC : '+floattostr(GCGC/total));
      end;

      listbox4.items.Add(inttostr(TBef));
    end;
    
    inc(iter);
    if( iter = totalbp-k+1) then timer1.Enabled := false;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  savingFileName : string;
begin
  savingFileName := FileName;
  delete(savingFileName,length(savingFileName)-3,4);
  savingFileName := savingFileName + '.dat';
  saving.SaveToFile(savingFileName);
  saving.Free;
  saving.Destroy;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  i : integer;
  temp : array[1..3] of integer;
  myFile : TextFile;
  max :integer;
  temp2 : array[0..5000] of integer;
  banding : integer;
begin
  series1.Clear;
  chart4.BottomAxis.Title.Caption := 'ORF Length';
  chart4.LeftAxis.Title.Caption := 'Amount';
  series9.Clear;

  max := -999;
  series1.Clear;
  for i := 0 to 5000 do begin
    temp2[i] := 0;
  end;
  banding := 0;
  if (label1.Caption = 'Label1') then ShowMessage('Open File First!')
  else if not fileexists(label3.Caption) then begin
    ShowMessage('File Not Found!'+#13+'Process The File First!');
    PageControl1.ActivePage := TabSheet1;
  end
  else begin
    combobox1.Clear;
    AssignFile(myFile,label3.Caption);
    reset(myFile);
    i := 1;
    while not eof (myFile) do begin
      readln(myFile,temp[1],temp[2],temp[3]);
      combobox1.Items.Add('ORF'+inttostr(i));
      combobox2.Items.Add('ORF'+inttostr(i));
      series1.AddXY(i,temp[2] - temp[1]);
      inc(temp2[temp[2] - temp[1]]);

      if (temp[2] - temp[1]) > max then max := temp[2] - temp[1];
      if (temp[1] < 50000) then inc(banding);
      inc(i);
    end;
    BanyakORF := i-1;
  end;
  series1.Clear;
  for i := 0 to max do begin
    series1.AddXY(i,temp2[i]);
  end;
  showMessage(inttostr(banding));
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  openedORF : string;
begin
  listbox2.Clear;
  openedORF := combobox1.Text;
  delete(openedORF,1,3);
  openORF(strtoint(openedORF));
end;


function TForm1.translate(s : string):string;
begin
  if (s = 'ATG') then translate := '---START---'
  {TXX}
  else if (s = 'TTT')or(s = 'TTC') then translate := 'Phe'
  else if (s = 'TTA')or(s = 'TTG') then translate := 'Leu'
  else if (s = 'TCT')or(s = 'TCC')or(s = 'TCA')or(s = 'TCG') then translate := 'Ser'
  else if (s = 'TAT')or(s = 'TAC') then translate := 'Tyr'
  else if (s = 'TAA')or(s = 'TAG')or(s = 'TGA') then translate := '---Stop---'
  else if (s = 'TGT')or(s = 'TGC') then translate := 'Cys'
  else if (s = 'TGG') then translate := 'Trp'

  {CXX}
  else if (s = 'CTA')or(s = 'CTG')or(s = 'CTC')or(s = 'CTT') then translate := 'Leu'
  else if (s = 'CCT')or(s = 'CCC')or(s = 'CCG')or(s = 'CCA') then translate := 'Pro'
  else if (s = 'CGA')or(s = 'CGG')or(s = 'CGC')or(s = 'CGT') then translate := 'Arg'
  else if (s = 'CAT')or(s = 'CAC') then translate := 'His'
  else if (s = 'CAA')or(s = 'CAG') then translate := 'Gln'

  {AXX}
  else if (s = 'ATT')or(s = 'ATC')or(s = 'ATA') then translate := 'Ile'
  else if (s = 'ACT')or(s = 'ACG')or(s = 'ACC')or(s = 'ACA') then translate := 'Thr'
  else if (s = 'AAT')or(s = 'AAC') then translate := 'Asn'
  else if (s = 'AAA')or(s = 'AAG') then translate := 'Lys'
  else if (s = 'AGT')or(s = 'AGC') then translate := 'Ser'
  else if (s = 'AGA')or(s = 'AGG') then translate := 'Arg'

  {GXX}
  else if (s = 'GTT')or(s = 'GTC')or(s = 'GTG')or(s = 'GTA') then translate := 'Val'
  else if (s = 'GCG')or(s = 'GCC')or(s = 'GCA')or(s = 'GCT') then translate := 'Ala'
  else if (s = 'GGT')or(s = 'GGC')or(s = 'GGA')or(s = 'GGG') then translate := 'Gly'
  else if (s = 'GAT')or(s = 'GAC') then translate := 'Asp'
  else if (s = 'GAA')or(s = 'GAG') then translate := 'Glu'


  else translate := 'unknown';
end;

Procedure TForm1.openORF(index : integer);
var
  myFile : textFile;
  temp,codon : string;
  ch : char;
  StartPos,StopPos,Frame : int64;
  i : integer;
  //detectiing GTAG for splicing area
  GTstart, AGend : string;
begin
  assignFile(myFile,label3.Caption);
  reset(myFile);
  i := 1;
  transvalorf := '';
  while (i < index) do begin readln(myFile,temp);inc(i);end;
  readln(myFile,StartPos,StopPos,Frame);
  edit7.Text := inttostr(startPos);
  closeFile(myFile);

  assignFile(myFile,label1.Caption);
  reset(myFile);
  readln(myFile,temp);
  if not checkbox1.Checked then begin
    listbox2.Items.add('ORF'+inttostr(index));
    listbox2.Items.Add('Panjang ORF : '+inttostr(stopPos -Startpos+1));
    listbox2.Items.Add('======');
    listbox2.Items.add('');
  end;

  i := 1;
  while (i < startPos) do begin
    read(myFile,ch);
    if (ch <> chr(13))And(ch <>chr(10)) then inc(i);
  end;

  i := startPos;
  while (i <= StopPos) do begin
    read(myFile,ch);
    if (ch <> chr(13))And(ch <>chr(10)) then INC(i);

    //-------------------------finding Intron------------------------
    if removingIntron.Checked then
      if (ch = 'G') then GTstart := GTstart + 'G'
      else if (GTStart = 'G')and(ch = 'T')then begin
        //delete the latest char that contain G
        delete(codon,length(codon),1);
        //splicing
        AGend := '';
        temp := '';
        while (AGend <> 'AG'){and(not eof(myFile))} do begin
          read(myFile,ch);
          if (ch <> chr(13))And(ch <>chr(10)) then inc(i);

          temp := temp+ch;
          if ch = 'A' then AGend := AGend + 'A'
          else if (AGend = 'A')and (ch = 'G') then begin
            AGend := 'AG';
            read(myfile,ch);
            if (ch <> chr(13))And(ch <>chr(10)) then inc(i);
          end
          else if eof(myFile) then begin
            delete(codon,length(codon),1);
            break;
          end
          else AGend := '';
        end;

        GTstart := '';
      end
      else GTstart :='';
    //-------------------------------end of Detecting Intron------------------------
    if (ch <> chr(13))And(ch <>chr(10)) then begin
      codon := codon + ch;
      TransValORF := TransValORF + ch;
    end;
    if(length(codon) = 3) then begin
      if not checkbox1.Checked then
      listbox2.Items.add(inttostr(i-3)+' '+codon+' '+translate(codon));
      codon := '';
    end
    else if (i = StopPos+1)and(not checkbox1.Checked) then  listbox2.Items.add(inttostr(i-3)+' '+codon+' '+translate(codon));
  end;
  edit6.Text := transvalorf;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  index : string;
begin
  label8.Caption := listbox2.Items[0];
  index := combobox1.Text;
  delete(index,1,3);
  DNAv.Text := CopyORF(strtoint(index));
end;

function TForm1.copyORF(index : integer):string;
var
  myFile : textFile;
  temp,codon : string;
  ch : char;
  StartPos,StopPos,Frame : int64;
  i : integer;

  //IntronExon
  GTstart, AGend : string;
begin
  assignFile(myFile,label3.Caption);
  reset(myFile);
  i := 1;

  //  get the ORF number list
  while (i < index) do begin readln(myFile,temp);inc(i);end;
  readln(myFile,StartPos,StopPos,Frame);
  closeFile(myFile);

  assignFile(myFile,label1.Caption);
  reset(myFile);
  readln(myFile,temp);
  i := 1;
  while (i < startPos) do begin
    read(myFile,ch);
    if (ch <> chr(13))And(ch <>chr(10)) then inc(i);
  end;
  i := startPos;

  while (i <= StopPos) do begin
    read(myFile,ch);
    if (ch <> chr(13))And(ch <>chr(10)) then inc(i);

    //-------------------------finding Intron------------------------
    if removingIntron.Checked then
      if (ch = 'G') then GTstart := GTstart + 'G'
      else if (GTStart = 'G')and(ch = 'T')then begin
        //delete the latest char that contain G
        delete(codon,length(codon),1);
        //splicing
        AGend := '';
        temp := '';
        while (AGend <> 'AG'){and(not eof(myFile))} do begin
          read(myFile,ch);
          if (ch <> chr(13))And(ch <>chr(10)) then inc(i);

          temp := temp+ch;
          if ch = 'A' then AGend := AGend + 'A'
          else if (AGend = 'A')and (ch = 'G') then begin
            AGend := 'AG';
            read(myfile,ch);
            if (ch <> chr(13))And(ch <>chr(10)) then inc(i);
          end
          else if eof(myFile) then begin
            delete(codon,length(codon),1);
            break;
          end
          else AGend := '';
        end;

        GTstart := '';
      end
      else GTstart :='';
    //-------------------------------end of Detecting Intron------------------------

    if (ch <> chr(13))And(ch <>chr(10)) then begin
      codon := codon + ch;
    end;
  end;

  copyORF := codon;
  closeFile(myFile);
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  index : string;
begin
  index := combobox1.Text;
  label8.Caption := listbox2.Items.ValueFromIndex[0];
  delete(index,1,3);
  DNAw.Text := CopyORF(strtoint(index));
end;

Function TForm1.LCS(v,w : string):real;
var
  i,j,a,b,c,m,n : integer;
  trig : boolean;
  res,res2 : string;
  score,totalscore,highestScore,lowestScore : integer;
  matchBonus,MisMatchPenalty,GapPenalty : integer;
begin
  res := '';
  res2 := '';
  memo1.Clear;
  matchBonus := strtoint(edit2.Text);
  MisMatchPenalty := strtoint(edit3.Text);
  GapPenalty := strtoint(edit4.Text);
  score := 0;
  highestScore := matchBonus*max(length(w),length(v));
  lowestScore := min((misMatchPenalty),(gappenalty))*max(length(w),length(v));
  totalScore := highestScore - LowestScore;


  // ------------------------making scoring matrices----------------------------

  // matrikx m x n
  m := length(v);
  n := length(w);

  //  Kondisi scoring awal
  for i := 0 to m do begin {direction[i,0] := 1;} scoring[i,0] := 0;end;
  for i := 0 to n do begin {direction[0,i] := 1;} scoring[0,i] := 0;end;

  //
  for i := 1 to n do begin
    for j := 1 to m do begin
      // trig digunakan untuk prioritas pemilihan arah
      // Jika trig true, maka prioritas corner,up,left
      // Jika trig false, maka prioritas up,corner left
      //  mismatch
      if (v[j] = w[i]) then begin trig := false; c := scoring[j-1,i-1]+MatchBonus;end
      else begin trig := true; c := scoring[j-1,i-1]+MisMatchPenalty;end;
      //  gap
      a := scoring[j,i-1]+GapPenalty;
      b := scoring[j-1,i]+GapPenalty;

      scoring[j,i] := max(max(a,b),c);
      // direction rule
      // 1 for up;
      // 2 for left
      // 3  for corner
      direction[j,i] := maxx(a,b,c,trig);
       //memo1.Text := memo1.Text + inttostr(scoring[j,i])+inttostr(direction[j,i]) + ' ';
    end;
    //memo1.Text := memo1.Text + sLineBreak;
  end;
  //------------------Scoring and Direction matrices done-----------------------

  //-------------------------Reverse Tracking-----------------------------------
  i := n;
  j := m;

  // Total Possible Score
  // highest score come if ALL nt are same, while the rest are gap only

  while (i >= 0)and (j >= 0) do begin

    //  memo1.Text := memo1.Text + inttostr(j) +' '+inttostr(i)+sLineBreak;

    //  string v
    if (direction[j,i] = 3)and(i > 0)and(j > 0) then res := v[j] + res
    else if (direction[j,i] = 2)and(i > 0)and(j > 0) then res := v[j] + res
    else if (direction[j,i] = 1)and(i > 0)and(j > 0) then res := '_'+ res
    else if (j = 0) and (i > 0) then res := '_' + res
    else if (i = 0) and (j > 0) then res := v[j]+ res;

    //string w
    if (direction[j,i] = 3)and(i > 0)and(j > 0) then res2 := w[i] + res2
    else if (direction[j,i] = 2)and(i > 0)and(j > 0) then res2 := '_' + res2
    else if (direction[j,i] = 1)and(i > 0)and(j > 0) then res2 := w[i]+ res2
    else if (j = 0)and(i > 0) then res2 := w[i] + res2
    else if (i = 0)and(j > 0) then res2 := '_'+ res2;

    if (direction[j,i] = 3)and( i> 0) and(j > 0) then begin dec(i);dec(j);end
    else if (direction[j,i] = 2)and (i>0) then dec(j)
    else if (direction[j,i] = 1)and (j>0) then dec(i)
    else if (j = 0) then dec(i)
    else if (i = 0) then dec(j);

    //  memo1.Text := memo1.Text + res + sLineBreak;
    if (i = 0)and(j = 0) then memo1.Text := memo1.Text
    else begin
      if not checkbox1.Checked then memo1.Text := res[1] +' '+res2[1]+sLineBreak+memo1.Text;
      if (res[1] = res2[1]) then score := score + strtoint(edit2.Text)
      else if (res[1] = '_')or(res2[1] = '_') then score := score + strtoint(edit4.Text)
      else score := score + strtoint(edit3.Text);
    end;
  end;
  if not checkbox1.Checked then memo1.Text := 'Score/TotalScore : '+inttostr(score)+' '+inttostr(TotalScore)+sLineBreak+memo1.Text;
  lcs := (score-lowestScore)/totalscore;
end;

function TForm1.maxx(a,b,c : integer;trig : boolean):integer;
begin
  if (trig) then begin
    if (c >= a)and (c >= b) then maxx := 3 //corner
    else if (a >= b) and (a >= c) then maxx := 1 //up
    else if (b >= a) and (b >= c) then maxx := 2; //left
  end
  else begin
    if (a >= b) and (a >= c) then maxx := 1 //up
    else if (c >= a )and (c >= b) then maxx := 3 //corner
    else if (b >= a) and (b >= c) then maxx := 2; //left
  end;
end;

procedure TForm1.buttonLCSClick(Sender: TObject);
var
  i : integer;
  index : string;
  scoreDist : array[-100..1000]of integer;
begin
  series1.Clear;
  chart4.BottomAxis.Title.Caption := 'ORF';
  chart4.LeftAxis.Title.Caption := 'Similarity';
  series9.Clear;
  if checkbox1.Checked then series9.Clear;
  LCS(dnaV.Text,dnaW.Text);
  if(checkbox1.Checked)then begin
    showMessage(inttostr(banyakORF));
    //use dnaV as center scoring
    for i := 1 to banyakORF do begin
      openORF(i);
      //showMessage('tol'+inttostr(i));
      //ShowMessage(inttostr(i)+' '+transValORF);
      series9.AddXY(i,LCS(dnaV.Text,transvalORF)*100);
    end;
  end;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  myFile1,myFile2 : textfile;
  temp : string;
  iter,k : int64;
  nAplus, nCplus, nGplus, nTplus : integer;
  nAmin, nCmin, nGmin, nTmin : integer;
  nA, nC, nG, nT, nAT, nGC : integer;
  nATplus, nGCplus : integer;
  nATmin,  nGCmin : integer;
  ch, chBef, ch2, chBef2 : char;
  rich,total : integer;
const
  A = 1;
  T = 2;
  G = 3;
  C = 4;
  AT = 5;
  GC = 6;
begin
  series5.Clear;
  series6.Clear;
  series7.Clear;
  series8.Clear;

  ATAT := 0;
  ATGC := 0;
  GCAT := 0;
  GCGC := 0;
  nA := 0;
  nG := 0;
  nC := 0;
  nT := 0;
  nAT := 0;
  nGC := 0;
  nAplus := 0;
  nGPlus := 0;
  nCPlus := 0;
  nTPlus := 0;
  nAMin := 0;
  nTMin := 0;
  nGMin := 0;
  nCMin := 0;
  nATPlus := 0;
  nGCPlus := 0;
  nATMin := 0;
  nGCMin := 0;

  iter := 0;
  series2.Clear;
  series3.Clear;
  series4.Clear;
  k := strtoint(edit5.Text);

  for rich := A to GC do begin
    n[rich,0] := 0;
    n[rich,1] := 0;
  end;

  rich := 0;
  assignFile(myFile1,FileName);
  reset(MyFile1);
  readln(myFile1,temp);

  assignFile(myFile2,FileName);
  reset(MyFile2);
  readln(myFile2,temp);
  while iter < totalBP do begin

    if (iter >= k) then begin
      read(myFile2,ch2);

      nA := nAplus - nAmin;
      nG := nGplus - nGmin;
      nC := nCplus - nCmin;
      nT := nTplus - nTmin;
      nAT := nATplus - nATmin;
      nGC := nGCplus - nGCmin;

      listbox3.Items.add(inttostr(nA)+' '+inttostr(nT)+' '+inttostr(nC)+' '+inttostr(nG));
      listbox3.Clear;
      series2.AddXY(iter-k,nAT/k);
      series3.AddXY(iter-k,nGC/k);
      series5.AddXY(iter-k,nA/k);
      series6.AddXY(iter-k,nT/k);
      series7.AddXY(iter-k,nG/k);
      series8.AddXY(iter-k,nC/k);

      if (iter > k) then begin
        if (rich = 0)and((nAT/k) > (nGC/k)) then inc(ATAT)
        else if (rich = 0)and((nAT/k) < (nGC/k)) then inc(ATGC)
        else if (rich = 1)and((nAT/k) > (nGC/k)) then inc(GCAT)
        else if (rich = 1)and((nAT/k) < (nGC/k)) then inc(GCGC)
      end;


      if (nAT/k) > (nGC/k) then Rich := 0 //  ATRich
      else if (nAT/k) < (nGC/k) then rich := 1 // GCRich
      else rich := rich;

      RichState[iter - k] := rich + 1;

      //  Kumpulan atgc
      n[A,rich] := n[A,rich]+nA;
      n[G,rich] := n[G,rich]+nG;
      n[C,rich] := n[C,rich]+nC;
      n[T,rich] := n[T,rich]+nT;

      if(chBef2 = 'A') and (ch2 = 'T') then inc(nATmin);
      if(chBef2 = 'G') and (ch2 = 'C') then inc(nGCmin);
      if (ch2 = 'A') then inc(nAmin);
      if (ch2 = 'G') then inc(nGmin);
      if (ch2 = 'C') then inc(nCmin);
      if (ch2 = 'T') then inc(nTmin);
      chBef2 := ch2;
    end;

    read(myFile1,ch);
    if(chBef = 'A') and (ch = 'T') then inc(nATplus);
    if(chBef = 'G') and (ch = 'C') then inc(nGCplus);
    if (ch = 'A') then inc(nAplus);
    if (ch = 'G') then inc(nGplus);
    if (ch = 'C') then inc(nCplus);
    if (ch = 'T') then inc(nTplus);
    chBef := ch;

    inc(iter);
  end;

  closeFile(myFile1);
  closeFile(myFile2);

  //plot
  listBox3.Items.add('AT Rich');
  total := n[A,0]+n[C,0]+n[G,0]+n[T,0];
  if total <>0 then begin
    listbox3.Items.add('A : '+floattostr(n[A,0]/total));
    listbox3.Items.add('T : '+floattostr(n[T,0]/total));
    listbox3.Items.add('G : '+floattostr(n[G,0]/total));
    listbox3.Items.add('C : '+floattostr(n[C,0]/total));

    transVal[1] := n[A,0]/total;
    transVal[2] := n[T,0]/total;
    transVal[3] := n[G,0]/total;
    transVal[4] := n[C,0]/total;
  end;

  listBox3.Items.add('GC Rich');
  total := n[A,1]+n[C,1]+n[G,1]+n[T,1];
  if total <>0 then begin
    listbox3.Items.add('A : '+floattostr(n[A,1]/total));
    listbox3.Items.add('T : '+floattostr(n[T,1]/total));
    listbox3.Items.add('G : '+floattostr(n[G,1]/total));
    listbox3.Items.add('C : '+floattostr(n[C,1]/total));

    transVal[5] := n[A,1]/total;
    transVal[6] := n[T,1]/total;
    transVal[7] := n[G,1]/total;
    transVal[8] := n[C,1]/total;
  end;

  listbox3.Items.add('Transitional Probability');
  total := ATAT+ ATGC;
  if total <>0 then begin
    listbox3.Items.add('AT-AT : '+floattostr(ATAT/total));
    listbox3.Items.add('AT-GC : '+floattostr(ATGC/total));
    transVal[9] := ATAT/total;
    transVal[10] := ATGC/total;
  end;
  total := GCAT + GCGC;
  if total <>0 then begin
    listbox3.Items.add('GC-AT : '+floattostr(GCAT/total));
    listbox3.Items.add('GC-GC : '+floattostr(GCGC/total));
    transVal[11] := GCAT/total;
    transVal[12] := GCGC/total;
  end;

  //Prefer
  total := ATAT+GCAT+ATGC+GCGC;
  if total <> 0 then begin
    transVal[13] := (ATAT + GCAT)/total;
    transVal[14] := (ATGC + GCGC)/total;
  end;

end;

procedure TForm1.Button8Click(Sender: TObject);
var
  i : int64;
  myFile : textFile;
  temp : string;
  ch : char;
  vNow, Vbef : array[0..1]of real;
  k,total0,total1,total2 : integer;

const
  A = 1;
  T = 2;
  G = 3;
  C = 4;
begin
  i := 0;
  k := strtoint(edit5.Text);
  AssignFile(myFile,FileName);
  reset(myFile);
  readln(myFile,temp);
  total0 := n[A,0]+n[T,0]+n[G,0]+n[C,0];
  total1 := n[A,1]+n[T,1]+n[G,1]+n[C,1];
  total2 := ATAT+ ATGC + GCAT+GCGC;

  while (not eof(myFIle)) do begin
    read(myFile,ch);
    if (ch = 'A')or(ch = 'T')or(ch = 'G')or(ch = 'C') then begin
      if(i = 0) then begin
        vNow[0] := 0.5 * n[mynt(ch),0]/total0;
        vNow[1] := 0.5 * n[mynt(ch),1]/total1;
      end
      else begin
        //showMessage(floattostr(vNow[0])+' '+floattostr(vNow[1]));
        vNow[0] := max(ATAT/total2*vBef[0]*n[mynt(ch),0]/total0, GCAT/total2*vBef[1]*n[mynt(ch),0]/total0);
        vNow[1] := max(GCGC/total2*vBef[1]*n[mynt(ch),1]/total1, ATGC/total2*vBef[0]*n[mynt(ch),1]/total1);
        if (vNow[0] > vNow[1]) then series4.addXY(i,0)
        else series4.AddXY(i,1);
      end;

      vBef[0] := vNow[0];
      vBef[1] := vNow[1];
      inc(i);
    end;
  end;
  closeFile(myFile);
end;

Function TForm1.mynt(ch :char):integer;
begin
  //showMessage(ch);
  if ch = 'A' then mynt := 1
  else if ch = 'T' then mynt := 2
  else if ch = 'G' then mynt := 3
  else if ch = 'C' then mynt := 4
  else Showmessage(ch +' error MYNT');
end;


procedure TForm1.Button10Click(Sender: TObject);
var
  i,j,k,spath : integer;
  lcMemo : TMemo;
  gen,strPath,lcl,temp,temp1 : string;
  mx : extended;
  t : array[1..8] of extended;
begin
  lcMemo := TMemo.Create(self);
   //init
   //assigning file
  lcl := FileName;
  delete(lcl,length(lcl)-3,4);
  lcl := lcl + '.tmp';
  memo2.Lines.LoadFromFile(lcl);
  gen := memo2.Lines.Text;
  for i := 1 to length(gen) do if(gen[i] <> chr(10))AND(gen[i] <> chr(13)) then temp := temp + gen[i];
  gen := temp;

  //gen :=transvalorf;
  edit6.Text := transvalorf;
  //memo3.Text := gen;

  //deklarasi emmision sudah sebelumnya
  //deklarasi transition
  for i := 1 to 9 do
    for j := 1 to 9 do begin
      // i itu state sebelumnya
      // j itu state sekarang
      transition[i,j] := 0.00001;
      if (j = 1) and(i = 8) then transition[i,j] := 0.6;
      if (j = 2) and(i = 1) then transition[i,j] := 1;
      if (j = 3) and(i = 2) then transition[i,j] := 1;
      if (j = 4) and(i = 3) then transition[i,j] := 1;
      if (j = 4) and(i = 4) then transition[i,j] := 0.6;//stay in Coding Region
      if (j = 5) and(i = 4) then transition[i,j] := 0.4;//going to stop
      if (j = 6) and(i = 5) then transition[i,j] := 1;
      if (j = 7) and(i = 6) then transition[i,j] := 1;
      if (j = 8) and(i = 7) then transition[i,j] := 1;
      if (j = 8) and(i = 8) then transition[i,j] := 0.4;
    end;

    //Emission
  for j := 1 to 9 do
    for i := 1 to 4 do begin
      emission[i,j] := 0.00001;
      emission[1,1] := 1; //A
      emission[2,2] := 1; //T
      emission[3,3] := 1; //G
      emission[1,4] := 0.25; //CR Emission
      emission[2,4] := 0.25; //CR Emission
      emission[3,4] := 0.25; //CR Emission
      emission[4,4] := 0.25; //CR Emission
      emission[2,5] := 1; //T
      emission[1,6] := 0.66; //A Stop Codon
      emission[3,6] := 0.33; //G Stop Codon
      emission[1,7] := 0.66; //A Stop Codon
      emission[3,7] := 0.33; //G Stop Codon
      emission[1,8] := 0.25; //CR Emission
      emission[2,8] := 0.25; //CR Emission
      emission[3,8] := 0.25; //CR Emission
      emission[4,8] := 0.25; //CR Emission
    end;

  for i := 1 to 9 do p[i,0] := 0.00001;
  //initial random start
  p[1,0] := -0.124;
  p[8,0] := -0.602;

  //forward
  i := 1;
  for i := 1 to length(gen) do
    if (gen[i] <> chr(10))and(gen[i]<>chr(13)) then
    for j := 1 to 8 do begin
      mx := -1000000;
      for k := 1 to 8 do begin
        // ini perkaliannya
        t[k] := (p[k,i-1]+log10(transition[k,j])+log10(emission[nuct(gen[i]),j]));
        if (t[k] > mx) then begin
          path[j,i] := k;
          mx := t[k];
        end;
      end;
      p[j,i] := mx;
      //listbox5.Items.add(floattostr(p[j,i]));
    end;


  //backward
  mx := -1000000;
  for i := 1 to 8 do begin
    if (p[i,length(gen)] >= mx) then begin
      mx := p[i,length(gen)];
      spath := i;
    end;
  end;

  for i := length(gen) downto 1 do begin
    lcmemo.Text := inttostr(spath)+lcmemo.Text;
    //if (spath >8) then showMessage(inttostr(spath)+' '+inttostr(i));
    spath := path[spath,i];
  end;

  //
  memo3.Clear;
  i := 1;
  temp := '';
  temp1 := '';
  while (i <= length(gen)) do begin
    temp := temp + gen[i];
    temp1 := temp1 + lcmemo.Text[i];
    if (i mod 50 = 0) then begin
      memo3.Lines.Add(temp);
      memo3.Lines.Add(temp1);
      temp1 := '';
      temp := '';
    end;
    inc(i);
  end;
  lcmemo.Destroy;
end;

function TForm1.nuct(s : char):integer;
begin
  if s = 'A' then nuct := 1
  else if s = 'T' then nuct := 2
  else if s = 'G' then nuct := 3
  else if s = 'C' then nuct := 4;
end;

procedure TForm1.Button11Click(Sender: TObject);
var
  lcl : string;
  i,j,k : integer;
  nA,nT,nG,nC,nAT,nGC : integer;
  plusA,plusT,plusG,plusC,plusAT,plusGC : integer;
  minA,minT,minG,minC,minAT,minGC,trig,total : integer;
  AT_A, AT_T, AT_G, AT_C : integer;
  GC_A, GC_T, GC_G,GC_C : integer;
  lcStr, dimer, dimer1 : string;
begin
  series2.Clear;
  series3.Clear;
  listbox3.Clear;
  //assigning file
  lcl := FileName;
  delete(lcl,length(lcl)-3,4);
  lcl := lcl + '.tmp';
  memo2.Lines.LoadFromFile(lcl);
  lcStr := memo2.Lines.Text;
  k := strtoint(edit5.Text);
  plusA := 0;
  plusT := 0;
  plusG := 0;
  plusC := 0;
  minA := 0;
  minT := 0;
  minG := 0;
  minC := 0;
  nA := 0;
  nT := 0;
  nG := 0;
  nC := 0;
  nAT := 0;
  nGC := 0;
  plusAT := 0;
  plusGC := 0;
  minAT := 0;
  minGC := 0;
  j := 1;
  for i := 1 to length(lcSTR) do begin

    if (i >= k) then begin
      nA := plusA - minA;
      nT := plusT - minT;
      nG := plusG - minG;
      nC := plusC - minC;
      nAT := plusAT - minAT;
      nGC := plusGC - minGC;

      // jumlah dimer
      if (lcSTR[j] <> chr(10))and(lcstr[j]<>chr(13)) then dimer1 := dimer1 + lcSTR[j];
      if (length(dimer1) = 2) then begin
        if dimer1 = 'AT' then inc(minAT)
        else if (dimer1 = 'GC')then inc(minGC);
        dimer1 := '';
      end;
      //monomer
      if (lcSTR[j] <> chr(10))and(lcstr[j]<>chr(13))then begin
        if (lcSTR[j] = 'A') then inc(minA);
        if (lcSTR[j] = 'T') then inc(minT);
        if (lcSTR[j] = 'G') then inc(minG);
        if (lcSTR[j] = 'C') then inc(minC);
      end;

      series2.AddXY(i-k,nAT/k);
      series3.AddXY(i-k,nGC/k);

      series5.AddXY(i-k,nA/k);
      series6.AddXY(i-k,nT/k);
      series7.AddXY(i-k,nG/k);
      series8.AddXY(i-k,nC/k);

      //ATrich = 1; GCrich = 0;j=1
      if (j = 1)and(nAT > nGC) then trig := 1
      else if (j = 1)and (nGC > nAT) then trig := 0;

      //transitional
      if (trig = 1)and(nAT > nGC) then inc(ATAT)
      else if (trig = 1)and(nAT < nGC) then inc(ATGC)
      else if (trig = 0)and(nAT < nGC) then inc(GCGC)
      else if (trig = 0)and(nAT > nGC) then inc(GCAT);

      //emission
      if (trig = 1) then begin
        AT_A := nA;
        AT_T := nT;
        AT_G := nG;
        AT_C := nC;
      end
      else begin
        GC_A := nA;
        GC_T := nT;
        GC_G := nG;
        GC_C := nC;
      end;

      //ATrich = 1; GCrich = 0;j>1
      if (j > 1)and(nAT > nGC) then trig := 1
      else if (j > 1)and (nGC > nAT) then trig := 0;

      inc(j);
    end;

    //dimer
    if (lcSTR[i] <> chr(10))and(lcstr[i]<>chr(13)) then  dimer := dimer + lcSTR[i];
    if (length(dimer) = 2) then begin
      if dimer = 'AT' then inc(plusAT)
      else if (dimer = 'GC')then inc(plusGC);
      dimer := '';
    end;
    //monomer
    if (lcSTR[i] <> chr(10))and(lcstr[i]<>chr(13)) then begin
      if (lcSTR[i] = 'A') then inc(plusA);
      if (lcSTR[i] = 'T') then inc(plusT);
      if (lcSTR[i] = 'G') then inc(plusG);
      if (lcSTR[i] = 'C') then inc(plusC);
    end;
  end;

  listbox3.Items.add('AT Rich');
  total := AT_A + AT_T + AT_G + AT_C;
  if (total <>0) then begin
    listbox3.Items.add(' A '+floattostr(AT_A/total));
    listbox3.Items.add(' T '+floattostr(AT_T/total));
    listbox3.Items.add(' G '+floattostr(AT_G/total));
    listbox3.Items.add(' C '+floattostr(AT_C/total));
  end;

  listbox3.Items.add('GC Rich');
  total := GC_A + GC_T + GC_G + GC_C;
  if (total <>0) then begin
    listbox3.Items.add(' A '+floattostr(GC_A/total));
    listbox3.Items.add(' T '+floattostr(GC_T/total));
    listbox3.Items.add(' G '+floattostr(GC_G/total));
    listbox3.Items.add(' C '+floattostr(GC_C/total));
  end;

  listbox3.Items.Add('Transitional Probability');
  total := ATAT + ATGC ;
  if (total <>0) then begin
    listbox3.Items.add('AT-AT '+floattostr(ATAT/total));
    listbox3.Items.add('AT-GC '+floattostr(ATGC/total));
  end;

  total := GCGC + GCAT;
  if (total <>0) then begin
    listbox3.Items.add('GC-AT '+floattostr(GCAT/total));
    listbox3.Items.add('GC-GC '+floattostr(GCGC/total));
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  memo2.Visible := false;
end;

procedure TForm1.Button12Click(Sender: TObject);
var
  i,j,k,spath,sum : integer;
  lcMemo : TMemo;
  gen,strPath,lcl,temp,temp1,simpan,temp2 : string;
  mx : extended;
  t : array[1..2] of extended;
begin

  // Variabel
  edit8.Text  := floattostr(transVal[1]);
  edit9.Text  := floattostr(transVal[2]);
  edit10.Text := floattostr(transVal[3]);
  edit11.Text := floattostr(transVal[4]);

  edit12.Text := floattostr(transVal[5]);
  edit13.Text := floattostr(transVal[6]);
  edit14.Text := floattostr(transVal[7]);
  edit15.Text := floattostr(transVal[8]);

  edit16.Text := floattostr(transVal[9]);
  edit17.Text := floattostr(transVal[10]);
  edit18.Text := floattostr(transVal[11]);
  edit19.Text := floattostr(transVal[12]);

  lcMemo := TMemo.Create(self);
   //init
   //assigning file
  lcl := FileName;
  delete(lcl,length(lcl)-3,4);
  lcl := lcl + '.tmp';
  memo2.Lines.LoadFromFile(lcl);
  gen := memo2.Lines.Text;
  for i := 1 to length(gen) do if(gen[i] <> chr(10))AND(gen[i] <> chr(13)) then temp := temp + gen[i];
  gen := temp;

  //gen :=transvalorf; //discomment this when you want to use specific ORF ATGC Rich analysis
  edit6.Text := transvalorf;
  gen := edit6.Text;
  //memo3.Text := gen;

  //deklarasi transition
  for i := 1 to 2 do
    for j := 1 to 2 do begin
      // i itu state sebelumnya
      // j itu state sekarang
      transition[i,j] := 0;
      if (j = 1) and(i = 1) then transition[i,j] := strtofloat(edit16.Text);//ATAT
      if (j = 1) and(i = 2) then transition[i,j] := strtofloat(edit18.Text);//GCAT
      if (j = 2) and(i = 1) then transition[i,j] := strtofloat(edit17.Text);//ATGC
      if (j = 2) and(i = 2) then transition[i,j] := strtofloat(edit19.Text);//GCGC
    end;

    //Emission
    //state 4 ATrich
    emission[1,1] := strtofloat(Edit8.Text);
    emission[2,1] := strtofloat(Edit9.Text);
    emission[3,1] := strtofloat(Edit10.Text);
    emission[4,1] := strtofloat(Edit11.Text);
    //state 5 GCrich
    emission[1,2] := strtofloat(Edit12.Text);
    emission[2,2] := strtofloat(Edit13.Text);
    emission[3,2] := strtofloat(Edit14.Text);
    emission[4,2] := strtofloat(Edit15.Text);

  //belum sesuai obervasi
  listbox5.Items.add(floattostr(log10(transVal[13])));
  {
  p[1,0] := log10(transVal[13]);
  p[2,0] := log10(transVal[13]);
  }
  p[1,0] := -0.30102999566;
  p[2,0] := -0.30102999566;


  //forward
  i := 1;
  for i := 1 to length(gen) do
    if (gen[i] <> chr(10))and(gen[i]<>chr(13)) then
    for j := 1 to 2 do begin
      mx := -100000;
      for k := 1 to 2 do begin
        // ini perkaliannya
        t[k] := (p[k,i-1]+log10(transition[k,j])+log10(emission[nuct(gen[i]),j]));
        if (t[k] > mx) then begin
          path[j,i] := k;
          mx := t[k];
        end;
      end;
      p[j,i] := mx;
    end;


  //backward
  mx := -100000;
  for i := 1 to 2 do begin
    if (p[i,length(gen)] > mx) then begin
      mx := p[i,length(gen)];
      spath := i;
    end;
  end;

  for i := length(gen) downto 1 do begin
    lcmemo.Text := inttostr(spath)+lcmemo.Text;
    spath := path[spath,i];
  end;

  memo3.Clear;
  i := 1;
  temp := '';
  temp1 := '';
  sum := 0;

  while (i <= length(gen)) do begin

    temp := temp+ gen[i];
    temp1 := temp1+ lcmemo.Text[i];
    temp2 := temp2 + inttostr(RichState[i+strtoint(edit7.Text)-1]);

    if (i mod 51 = 0) then begin
      for j := 1 to 51 do if (temp1[j] = temp2[j]) then inc(sum);
      memo3.Lines.Add(temp);
      memo3.Lines.Add(temp1);
      memo3.Lines.Add(temp2);

      memo3.Lines.Add(' ');
      temp2 := '';
      temp1 := '';
      temp := '';
    end;

    if lcmemo.Text[i] <> lcmemo.Text[i-1]then listbox5.Items.Add(inttostr(i) +' '+ lcmemo.Text[i-1]);
    inc(i);
  end;

  //last
  for j := 1 to length(temp1) do if (temp1[j] = temp2[j]) then inc(sum);
  memo3.Lines.Add(temp);
  memo3.Lines.Add(temp1);
  memo3.Lines.Add(temp2);

  memo3.Lines.Add(' ');
  temp2 := '';
  temp1 := '';
  temp := '';

  listbox5.Items.add('%benar : ' + floattostr(sum/(length(gen)- length(gen) div 51)));
  sum := 0;
  //delete ekstensi 3 huruf diakhir
  simpan := fileName;
  delete(simpan,length(simpan)-3,4);
  //lcmemo.Lines.SaveToFile(simpan+'.sav');

  lcmemo.Destroy;
end;

procedure TForm1.Button13Click(Sender: TObject);
var
  i,j,k,spath,awal,sum,trig : integer;
  lcMemo : TMemo;
  gen,strPath,lcl,temp,temp1,temp2,codon : string;
  mx,t1,t2 : extended;
  t : array[1..14] of extended;
begin
  listbox5.Clear;
  lcMemo := TMemo.Create(self);
   //init
   //assigning file
  lcl := FileName;
  delete(lcl,length(lcl)-3,4);
  lcl := lcl + '.tmp';
  memo2.Lines.LoadFromFile(lcl);
  gen := memo2.Lines.Text;
  for i := 1 to length(gen) do if(gen[i] <> chr(10))AND(gen[i] <> chr(13)) then temp := temp + gen[i];
  gen := temp;
  totalBP := length(gen);

  T1 := strtofloat(edit20.Text);
  T2 := strtofloat(edit21.Text);
  //deklarasi emmision sudah sebelumnya
  //deklarasi transition
  for i := 1 to 12 do
    for j := 1 to 12 do begin
      //i itu state sebelumnya
      //j itu state sekarang
      transition[i,j] := 1E-10;

      {if (i = 1)and(j = 2) then transition[i,j] := 1;
      if (i = 2)and(j = 3) then transition[i,j] := 1;
      if (i = 3)and(j = 4) then transition[i,j] := 0.5;
      if (i = 3)and(j = 7) then transition[i,j] := 0.5;
      if (i = 4)and(j = 5) then transition[i,j] := 1;
      if (i = 5)and(j = 6) then transition[i,j] := 1;
      if (i = 6)and(j = 4) then transition[i,j] := 1/3;
      if (i = 6)and(j = 7) then transition[i,j] := 2/3;
      if (i = 7)and(j = 8) then transition[i,j] := 1/3;
      if (i = 7)and(j = 10) then transition[i,j] := 2/3;
      if (i = 8)and(j = 9) then transition[i,j] := 1;
      if (i = 9)and(j = 12) then transition[i,j] := 1;
      if (i = 10)and(j = 11) then transition[i,j] := 1;
      if (i = 11)and(j = 12) then transition[i,j] := 1;
      if (i = 12)and(j = 13) then transition[i,j] := 1;
      if (i = 13)and(j = 14) then transition[i,j] := 1;
      if (i = 14)and(j = 1) then transition[i,j] := 0.5;
      if (i = 14)and(j = 12) then transition[i,j] := 0.5;}



      if (i = 1)and(j = 2) then transition[i,j] := 1;
      if (i = 2)and(j = 3) then transition[i,j] := 1;

      if (i = 3)and(j = 4) then transition[i,j] := 1;
      if (i = 4)and(j = 5) then transition[i,j] := 1;
      if (i = 5)and(j = 6) then transition[i,j] := 1;

      if (i = 6)and(j = 4) then transition[i,j] := 1-T1;
      if (i = 6)and(j = 7) then transition[i,j] := T1;
      if (i = 7)and(j = 8) then transition[i,j] := 1;
      if (i = 8)and(j = 9) then transition[i,j] := 1;
      if (i = 9)and(j = 10) then transition[i,j] := 1;
      if (i = 10)and(j = 11) then transition[i,j] := 1;
      if (i = 11)and(j = 12) then transition[i,j] := 1;
      if (i = 12)and(j = 10) then transition[i,j] := 1-T2;
      if (i = 12)and(j = 1) then transition[i,j] := T2;

    end;

  for j := 1 to 12 do
    for i := 1 to 4 do begin
      emission[i,j] := 1E-10;

      emission[1,1] := 1; //A
      emission[2,2] := 1; //T
      emission[3,3] := 1; //G


      emission[1,4] := 0.25; //CR Emission
      emission[2,4] := 0.25; //CR Emission
      emission[3,4] := 0.25; //CR Emission
      emission[4,4] := 0.25; //CR Emission

      emission[1,5] := 0.25; //CR Emission
      emission[2,5] := 0.25; //CR Emission
      emission[3,5] := 0.25; //CR Emission
      emission[4,5] := 0.25; //CR Emission

      emission[1,6] := 0.25; //CR Emission
      emission[2,6] := 0.25; //CR Emission
      emission[3,6] := 0.25; //CR Emission
      emission[4,6] := 0.25; //CR Emission

      emission[2,7] := 1; //T

      emission[1,8] := 0.66;
      emission[3,8] := 0.33;

      emission[1,9] := 0.66;
      emission[3,9] := 0.33;

      emission[1,10] := 0.25; //CR Emission
      emission[2,10] := 0.25; //CR Emission
      emission[3,10] := 0.25; //CR Emission
      emission[4,10] := 0.25; //CR Emission

      emission[1,11] := 0.25; //CR Emission
      emission[2,11] := 0.25; //CR Emission
      emission[3,11] := 0.25; //CR Emission
      emission[4,11] := 0.25; //CR Emission

      emission[1,12] := 0.25; //CR Emission
      emission[2,12] := 0.25; //CR Emission
      emission[3,12] := 0.25; //CR Emission
      emission[4,12] := 0.25;

      {emission[1,8] := 1; //A Stop Codon

      emission[1,9] := 1;
      emission[3,9] := 1;

      emission[3,10] := 1;

      emission[1,11] := 1;

      emission[1,12] := 0.25; //CR Emission
      emission[2,12] := 0.25; //CR Emission
      emission[3,12] := 0.25; //CR Emission
      emission[4,12] := 0.25; //CR Emission
      emission[1,13] := 0.25; //CR Emission
      emission[2,13] := 0.25; //CR Emission
      emission[3,13] := 0.25; //CR Emission
      emission[4,13] := 0.25; //CR Emission
      emission[1,14] := 0.25; //CR Emission
      emission[2,14] := 0.25; //CR Emission
      emission[3,14] := 0.25; //CR Emission
      emission[4,14] := 0.25; //CR Emission
      }
    end;

  for i := 1 to 12 do p[i,0] := -8;
  //initial random start
  p[1,0] := -0.30102999566;
  p[10,0] := -0.30102999566;

  //forward
  i := 1;
  for i := 1 to length(gen) do
    if (gen[i] <> chr(10))and(gen[i]<>chr(13)) then
    for j := 1 to 12 do begin
      mx := -1000000;
      for k := 1 to 12 do begin
        // ini perkaliannya
        t[k] := (p[k,i-1]+log10(transition[k,j])+log10(emission[nuct(gen[i]),j]));
        if (t[k] > mx) then begin
          path[j,i] := k;
          mx := t[k];
        end;
      end;
      p[j,i] := mx;
      //listbox5.Items.add(floattostr(p[j,i]));
    end;


  //backward
  mx := -1000000;
  for i := 1 to 12 do begin
    if (p[i,length(gen)] >= mx) then begin
      mx := p[i,length(gen)];
      spath := i;
    end;
  end;
  //showMessage('spath ' +inttostr(spath));

  lcmemo.Text := '';
  for i := length(gen) downto 1 do begin
    if (spath >=1 )and(Spath<=3) then lcmemo.Text := '1'+lcmemo.Text
    else if (spath >=4 )and(Spath<=6) then lcmemo.Text := '2'+lcmemo.Text
    else if (spath >=7 )and(Spath<=9) then lcmemo.Text := '3'+lcmemo.Text
    else if (spath >=10 )and(Spath<=12) then lcmemo.Text := '4'+lcmemo.Text;
    //lcmemo.Text := inttostr(spath)+lcmemo.Text;
    spath := path[spath,i];
  end;

  //

  memo3.Clear;
  i := 1;
  temp := '';
  temp1 := '';
  sum := 0;
  while (i <= length(gen)-3) do begin
    temp := temp + gen[i];
    codon := codon + gen[i];
    temp1 := temp1 + lcmemo.Text[i-1];
    if length(codon)  = 3 then begin
      if (codon = 'ATG') then begin
        temp2 := temp2 + '111';
        trig := 1;
      end
      else if (codon = 'TAA')or(codon = 'TAG')or(codon = 'TAA') then begin
        temp2 := temp2 + '333';
        trig := 0;
      end
      else if (trig = 1 ) then temp2 := temp2 + '222'
      else if trig = 0 then temp2 := temp2 + '444';

      codon := ''
    end;

    if (i mod 51 = 0) then begin
      //memo3.Lines.Add(temp);
      //memo3.Lines.Add(temp1);
      //memo3.Lines.Add(temp2);

      for j := 1 to 51 do if (temp1[j] = temp2[j]) then inc(sum);
      temp2 := '';
      temp1 := '';
      temp := '';
    end;
    inc(i);
  end;
  //memo3.Lines.Add(temp);
  //memo3.Lines.Add(temp1);
  //memo3.Lines.Add(temp2+codon);
    for j := 1 to 51 do if (temp1[j] = temp2[j]) then inc(sum);

  listbox5.Items.add('%benar : '+floattostr(sum/length(gen)*100));

  //plot ORF

  j := 0;
  sum := 0;
  for i := 1 to length(gen) do begin
    if (lcmemo.Text[i] = '1')and(lcmemo.Text[i+1] = '1')and(lcmemo.Text[i+2] = '1') then
      awal := i;
    if (lcmemo.Text[i] = '3')and(lcmemo.Text[i+1] = '3')and(lcmemo.Text[i+2] = '3') then begin
      //listbox5.Items.add(inttostr(awal) +' '+inttostr(i));
      sum := sum + i - awal + 1;
      inc(j);
      end;
  end;

  listbox5.Items.add('Banyak ORF = '+inttostr(j));
  listbox5.Items.add('Rerata Panjang = '+floattostr(sum/j));

  lcmemo.Destroy;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
var
  openedORF : string;
begin
  listbox2.Clear;
  openedORF := combobox1.Text;
  delete(openedORF,1,3);
  openORF(strtoint(openedORF));
end;

procedure TForm1.Button14Click(Sender: TObject);
var
  i,j : integer;
  temp : string;
begin
  memo4.Clear;
  memo4.Lines.Add('Basa 0 - 20');
  memo4.Lines.Add('Forward');
  for j := 1 to 12 do begin
    temp := '';
    for i := 0 to 20 do begin
      temp := temp +floattostrf(p[j,i],ffFixed,8,4)+#9;
    end;
    memo4.Lines.Add(temp);
  end;

  memo4.Lines.Add(' ');
  memo4.Lines.Add(' ');
  memo4.Lines.Add('Path');
  for j := 1 to 12 do begin
    temp := '';
    for i := 1 to 20 do begin
      {if (path[j,i] >=1 )and(path[j,i]<=3) then temp := temp + '1' +#9
      else if (path[j,i] >=4 )and(path[j,i]<=6) then temp := temp + '2' +#9
      else if (path[j,i] >=7 )and(path[j,i]<=9) then temp := temp + '3' +#9
      else if (path[j,i] >=10 )and(path[j,i]<=12) then temp := temp + '4' +#9;}

      temp := temp + floattostr(path[j,i])+#9;
    end;
    memo4.Lines.Add(temp);
  end;

  ////

  memo5.Clear;
  memo5.Lines.Add('20 Basa Terakhir');
  memo5.Lines.Add('Forward');
  for j := 1 to 12 do begin
    temp := '';
    for i := totalBP-20 to totalBP do begin
      temp := temp +floattostrf(p[j,i],ffFixed,8,4)+#9;
    end;
    memo5.Lines.Add(temp);
  end;

  memo5.Lines.Add(' ');
  memo5.Lines.Add(' ');
  memo5.Lines.Add('Path');
  for j := 1 to 12 do begin
    temp := '';
    for i := totalBP-20 to totalBP do begin
      {if (path[j,i] >=1 )and(path[j,i]<=3) then temp := temp + '1' +#9
      else if (path[j,i] >=4 )and(path[j,i]<=6) then temp := temp + '2' +#9
      else if (path[j,i] >=7 )and(path[j,i]<=9) then temp := temp + '3' +#9
      else if (path[j,i] >=10 )and(path[j,i]<=12) then temp := temp + '4' +#9;}
      
      temp := temp + floattostr(path[j,i])+#9;
    end;
    memo5.Lines.Add(temp);
  end;

end;

end.
