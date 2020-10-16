object Form1: TForm1
  Left = 26
  Top = 58
  Width = 1386
  Height = 788
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 88
    Top = 8
    Width = 48
    Height = 20
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Open File'
    TabOrder = 0
    OnClick = Button1Click
  end
  object RichEdit1: TRichEdit
    Left = 8
    Top = 80
    Width = 273
    Height = 609
    Lines.Strings = (
      'RichEdit1')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object RichEdit2: TRichEdit
    Left = 8
    Top = 48
    Width = 273
    Height = 25
    Lines.Strings = (
      'RichEdit2')
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 288
    Top = 48
    Width = 1073
    Height = 641
    ActivePage = TabSheet4
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'Overview'
      object Label2: TLabel
        Left = 616
        Top = 8
        Width = 15
        Height = 13
        Caption = 'L  :'
      end
      object ListBox1: TListBox
        Left = 8
        Top = 8
        Width = 177
        Height = 265
        ItemHeight = 13
        TabOrder = 0
      end
      object Button2: TButton
        Left = 192
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Find ORF'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Chart1: TChart
        Left = 192
        Top = 48
        Width = 865
        Height = 169
        Legend.CheckBoxes = True
        Title.Text.Strings = (
          'Persebaran Panjang ORF')
        BottomAxis.Title.Caption = 'Panjang ORF'
        LeftAxis.Title.Caption = 'Banyak'
        View3D = False
        TabOrder = 2
        object Frame1Series: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'Frame 1'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Frame2Series: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'Frame 2'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Frame3Series: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          SeriesColor = clBlue
          Title = 'Frame 3'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object Chart2: TChart
        Left = 192
        Top = 224
        Width = 865
        Height = 161
        Title.Text.Strings = (
          'Densitas Nukleotida')
        BottomAxis.Title.Caption = 'Window'
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.ExactDateTime = False
        LeftAxis.Increment = 0.001000000000000000
        LeftAxis.Maximum = 1.000000000000000000
        LeftAxis.Title.Caption = 'Frekuensi'
        RightAxis.ExactDateTime = False
        RightAxis.Increment = 0.001000000000000000
        View3D = False
        TabOrder = 3
        object Aseries: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'A'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Gseries: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'G'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Cseries: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'C'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Tseries: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'T'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object Chart3: TChart
        Left = 192
        Top = 400
        Width = 865
        Height = 169
        Title.Text.Strings = (
          'Densitas AT GC')
        BottomAxis.Title.Caption = 'Window'
        LeftAxis.Title.Caption = 'Frekuensi'
        View3D = False
        TabOrder = 4
        object ATSeries: TFastLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'A-T'
          LinePen.Color = clRed
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object GCSeries: TFastLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'G-C'
          LinePen.Color = clGreen
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object Button3: TButton
        Left = 528
        Top = 8
        Width = 81
        Height = 25
        Caption = 'Densitas'
        TabOrder = 5
        OnClick = Button3Click
      end
      object Edit1: TEdit
        Left = 640
        Top = 8
        Width = 57
        Height = 21
        TabOrder = 6
        Text = '90000'
      end
      object Button4: TButton
        Left = 272
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Save ORF'
        TabOrder = 7
        OnClick = Button4Click
      end
      object ListBox4: TListBox
        Left = 8
        Top = 280
        Width = 177
        Height = 289
        ItemHeight = 13
        TabOrder = 8
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'ORF'
      ImageIndex = 1
      object Label3: TLabel
        Left = 8
        Top = 8
        Width = 41
        Height = 16
        Caption = 'Label3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 440
        Top = 160
        Width = 63
        Height = 13
        Caption = 'Match Bonus'
      end
      object Label5: TLabel
        Left = 440
        Top = 192
        Width = 84
        Height = 13
        Caption = 'MisMatch Penalty'
      end
      object Label6: TLabel
        Left = 440
        Top = 224
        Width = 58
        Height = 13
        Caption = 'Gap Penalty'
      end
      object Label7: TLabel
        Left = 240
        Top = 64
        Width = 32
        Height = 13
        Caption = 'Label7'
      end
      object Label8: TLabel
        Left = 240
        Top = 96
        Width = 32
        Height = 13
        Caption = 'Label8'
      end
      object Button5: TButton
        Left = 8
        Top = 32
        Width = 75
        Height = 41
        Caption = 'Generate ORF'
        TabOrder = 0
        OnClick = Button5Click
      end
      object ComboBox1: TComboBox
        Left = 88
        Top = 53
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Text = 'ComboBox1'
        OnChange = ComboBox1Change
      end
      object ListBox2: TListBox
        Left = 8
        Top = 80
        Width = 225
        Height = 465
        ItemHeight = 13
        TabOrder = 2
      end
      object Button6: TButton
        Left = 8
        Top = 552
        Width = 113
        Height = 57
        Caption = 'Copy as v'
        TabOrder = 3
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 128
        Top = 552
        Width = 105
        Height = 57
        Caption = 'Copy as w'
        TabOrder = 4
        OnClick = Button7Click
      end
      object DNAw: TEdit
        Left = 312
        Top = 64
        Width = 737
        Height = 21
        TabOrder = 5
        Text = 'f'
      end
      object DNAv: TEdit
        Left = 312
        Top = 96
        Width = 737
        Height = 21
        TabOrder = 6
        Text = 'DNAv'
      end
      object buttonLCS: TButton
        Left = 240
        Top = 128
        Width = 809
        Height = 25
        Caption = 'ALIGN (LCS Method)'
        TabOrder = 7
        OnClick = buttonLCSClick
      end
      object Memo1: TMemo
        Left = 240
        Top = 160
        Width = 185
        Height = 417
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssVertical
        TabOrder = 8
      end
      object Edit2: TEdit
        Left = 544
        Top = 160
        Width = 121
        Height = 21
        TabOrder = 9
        Text = '1'
      end
      object Edit3: TEdit
        Left = 544
        Top = 192
        Width = 121
        Height = 21
        TabOrder = 10
        Text = '0'
      end
      object Edit4: TEdit
        Left = 544
        Top = 224
        Width = 121
        Height = 21
        TabOrder = 11
        Text = '0'
      end
      object RemovingIntron: TCheckBox
        Left = 88
        Top = 32
        Width = 97
        Height = 17
        Caption = 'Remove Intron'
        TabOrder = 12
      end
      object CheckBox1: TCheckBox
        Left = 952
        Top = 160
        Width = 97
        Height = 17
        Caption = 'CheckBox1'
        TabOrder = 13
      end
      object Chart4: TChart
        Left = 432
        Top = 264
        Width = 617
        Height = 250
        Legend.CheckBoxes = True
        Legend.CheckBoxesStyle = cbsRadio
        Title.Text.Strings = (
          'Grafik Persebaran ORF')
        BottomAxis.Title.Caption = 'Panjang ORF'
        LeftAxis.Title.Caption = 'Banyak'
        View3D = False
        TabOrder = 14
        object Series1: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series9: TLineSeries
          Active = False
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'HMM'
      ImageIndex = 2
      object ListBox3: TListBox
        Left = 8
        Top = 40
        Width = 273
        Height = 569
        ItemHeight = 13
        TabOrder = 0
      end
      object Edit5: TEdit
        Left = 160
        Top = 8
        Width = 121
        Height = 21
        TabOrder = 1
        Text = '1000'
      end
      object Button9: TButton
        Left = 8
        Top = 8
        Width = 145
        Height = 25
        Caption = 'Count'
        TabOrder = 2
        OnClick = Button9Click
      end
      object Chart5: TChart
        Left = 288
        Top = 24
        Width = 761
        Height = 281
        Legend.CheckBoxes = True
        Title.Text.Strings = (
          'AT-GC')
        BottomAxis.Title.Caption = 'BasePair'
        LeftAxis.Title.Caption = 'Probability'
        View3D = False
        TabOrder = 3
        object Series2: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'AT'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series3: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'GC'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series4: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          SeriesColor = clBlue
          Title = 'Viterbian'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object Button8: TButton
        Left = 288
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Button8'
        TabOrder = 4
        OnClick = Button8Click
      end
      object Button11: TButton
        Left = 368
        Top = 8
        Width = 113
        Height = 25
        Caption = 'Count using Memo'
        TabOrder = 5
        OnClick = Button11Click
      end
      object Chart6: TChart
        Left = 288
        Top = 320
        Width = 713
        Height = 289
        Title.Text.Strings = (
          'Nucleotide Density')
        View3D = False
        TabOrder = 6
        object Series5: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'pA'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series6: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'pT'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series7: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'pC'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series8: TLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = 'pG'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'HMM Model'
      ImageIndex = 3
      object Button10: TButton
        Left = 8
        Top = 8
        Width = 75
        Height = 25
        Caption = 'CRNCR'
        TabOrder = 0
        OnClick = Button10Click
      end
      object Edit6: TEdit
        Left = 8
        Top = 40
        Width = 433
        Height = 21
        TabOrder = 1
        Text = 'Edit6'
      end
      object Edit7: TEdit
        Left = 8
        Top = 64
        Width = 433
        Height = 21
        TabOrder = 2
        Text = 'Edit7'
      end
      object ListBox5: TListBox
        Left = 8
        Top = 96
        Width = 433
        Height = 177
        ItemHeight = 13
        TabOrder = 3
      end
      object Memo3: TMemo
        Left = 448
        Top = 40
        Width = 609
        Height = 569
        Lines.Strings = (
          'Memo3')
        ScrollBars = ssBoth
        TabOrder = 4
      end
      object Button12: TButton
        Left = 88
        Top = 8
        Width = 75
        Height = 25
        Caption = 'ATGC Rich'
        TabOrder = 5
        OnClick = Button12Click
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 280
        Width = 433
        Height = 177
        Caption = 'GroupBox1'
        TabOrder = 6
        object Label9: TLabel
          Left = 8
          Top = 20
          Width = 39
          Height = 13
          Caption = 'AT Rich'
        end
        object Label18: TLabel
          Left = 128
          Top = 20
          Width = 40
          Height = 13
          Caption = 'GC Rich'
        end
        object Label10: TLabel
          Left = 8
          Top = 44
          Width = 7
          Height = 13
          Caption = 'A'
        end
        object Label11: TLabel
          Left = 8
          Top = 76
          Width = 7
          Height = 13
          Caption = 'T'
        end
        object Label12: TLabel
          Left = 8
          Top = 108
          Width = 8
          Height = 13
          Caption = 'G'
        end
        object Label13: TLabel
          Left = 8
          Top = 140
          Width = 7
          Height = 13
          Caption = 'C'
        end
        object Label14: TLabel
          Left = 128
          Top = 44
          Width = 7
          Height = 13
          Caption = 'A'
        end
        object Label15: TLabel
          Left = 128
          Top = 76
          Width = 7
          Height = 13
          Caption = 'T'
        end
        object Label16: TLabel
          Left = 128
          Top = 108
          Width = 8
          Height = 13
          Caption = 'G'
        end
        object Label17: TLabel
          Left = 128
          Top = 140
          Width = 7
          Height = 13
          Caption = 'C'
        end
        object Label19: TLabel
          Left = 256
          Top = 44
          Width = 47
          Height = 13
          Caption = 'P(S4 | S4)'
        end
        object Label20: TLabel
          Left = 256
          Top = 76
          Width = 47
          Height = 13
          Caption = 'P(S5 | S4)'
        end
        object Label21: TLabel
          Left = 256
          Top = 108
          Width = 47
          Height = 13
          Caption = 'P(S4 | S5)'
        end
        object Label22: TLabel
          Left = 256
          Top = 140
          Width = 47
          Height = 13
          Caption = 'P(S5 | S5)'
        end
        object Edit8: TEdit
          Left = 24
          Top = 44
          Width = 89
          Height = 21
          TabOrder = 0
          Text = 'Edit8'
        end
        object Edit9: TEdit
          Left = 24
          Top = 76
          Width = 89
          Height = 21
          TabOrder = 1
          Text = 'Edit9'
        end
        object Edit10: TEdit
          Left = 24
          Top = 108
          Width = 89
          Height = 21
          TabOrder = 2
          Text = 'Edit10'
        end
        object Edit11: TEdit
          Left = 24
          Top = 136
          Width = 89
          Height = 21
          TabOrder = 3
          Text = 'Edit11'
        end
        object Edit12: TEdit
          Left = 144
          Top = 44
          Width = 89
          Height = 21
          TabOrder = 4
          Text = 'Edit12'
        end
        object Edit13: TEdit
          Left = 144
          Top = 76
          Width = 89
          Height = 21
          TabOrder = 5
          Text = 'Edit13'
        end
        object Edit14: TEdit
          Left = 144
          Top = 108
          Width = 89
          Height = 21
          TabOrder = 6
          Text = 'Edit14'
        end
        object Edit15: TEdit
          Left = 144
          Top = 140
          Width = 89
          Height = 21
          TabOrder = 7
          Text = 'Edit15'
        end
        object Edit16: TEdit
          Left = 312
          Top = 44
          Width = 89
          Height = 21
          TabOrder = 8
          Text = 'Edit16'
        end
        object Edit17: TEdit
          Left = 312
          Top = 76
          Width = 89
          Height = 21
          TabOrder = 9
          Text = 'Edit17'
        end
        object Edit18: TEdit
          Left = 312
          Top = 108
          Width = 89
          Height = 21
          TabOrder = 10
          Text = 'Edit18'
        end
        object Edit19: TEdit
          Left = 312
          Top = 140
          Width = 89
          Height = 21
          TabOrder = 11
          Text = 'Edit19'
        end
      end
      object Button13: TButton
        Left = 8
        Top = 464
        Width = 75
        Height = 49
        Caption = 'FindORF'
        TabOrder = 7
        OnClick = Button13Click
      end
      object ComboBox2: TComboBox
        Left = 224
        Top = 464
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 8
        Text = 'ComboBox2'
        OnChange = ComboBox2Change
      end
      object Edit20: TEdit
        Left = 88
        Top = 464
        Width = 121
        Height = 21
        TabOrder = 9
        Text = '0.6'
      end
      object Edit21: TEdit
        Left = 88
        Top = 496
        Width = 121
        Height = 21
        TabOrder = 10
        Text = '0.6'
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Forward Viterbi'
      ImageIndex = 4
      object Button14: TButton
        Left = 8
        Top = 504
        Width = 97
        Height = 25
        Caption = 'Langkah Viterbi'
        TabOrder = 0
        OnClick = Button14Click
      end
      object Memo4: TMemo
        Left = 8
        Top = 32
        Width = 513
        Height = 465
        Lines.Strings = (
          'Memo4')
        ScrollBars = ssHorizontal
        TabOrder = 1
      end
      object Memo5: TMemo
        Left = 536
        Top = 32
        Width = 521
        Height = 465
        Lines.Strings = (
          'Memo5')
        ScrollBars = ssHorizontal
        TabOrder = 2
      end
    end
  end
  object Memo2: TMemo
    Left = 1176
    Top = 8
    Width = 185
    Height = 33
    Lines.Strings = (
      'Memo2')
    TabOrder = 4
  end
  object OpenDialog1: TOpenDialog
    Left = 248
    Top = 9
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 172
    Top = 7
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 212
    Top = 9
  end
end
