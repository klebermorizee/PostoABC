object MovimentoRelForm: TMovimentoRelForm
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Movimentos'
  ClientHeight = 724
  ClientWidth = 785
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object MovimentosRLReport: TRLReport
    Left = -8
    Top = -8
    Width = 794
    Height = 1123
    AllowedBands = [btTitle, btDetail, btSummary]
    DataSource = MovimentoForm.MovimentoDataSource
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    BeforePrint = MovimentosRLReportBeforePrint
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 155
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = 176
        Top = 19
        Width = 342
        Height = 27
        Caption = 'RELAT'#211'RIO DE MOVIMENTOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -23
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel2: TRLLabel
        Left = 3
        Top = 64
        Width = 62
        Height = 16
        Caption = 'Per'#237'odo :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel3: TRLLabel
        Left = 3
        Top = 86
        Width = 62
        Height = 16
        Caption = 'Tanques:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel4: TRLLabel
        Left = 3
        Top = 108
        Width = 59
        Height = 16
        Caption = 'Bombas:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object PeriodoRLDBText: TRLDBText
        Left = 88
        Top = 64
        Width = 107
        Height = 16
        Text = ''
      end
      object TanquesRLDBText: TRLDBText
        Left = 88
        Top = 86
        Width = 112
        Height = 16
        Text = ''
      end
      object BombasRLDBText: TRLDBText
        Left = 88
        Top = 108
        Width = 111
        Height = 16
        Text = ''
      end
      object RLDraw1: TRLDraw
        Left = 2
        Top = 127
        Width = 713
        Height = 25
      end
      object TanqueRLLabel: TRLLabel
        Left = 45
        Top = 130
        Width = 52
        Height = 16
        Caption = 'Tanque'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 190
        Top = 130
        Width = 49
        Height = 16
        Caption = 'Bomba'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 376
        Top = 131
        Width = 42
        Height = 16
        Caption = 'Valor '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 508
        Top = 133
        Width = 39
        Height = 16
        Caption = 'Litros'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel8: TRLLabel
        Left = 558
        Top = 132
        Width = 151
        Height = 16
        Caption = 'Data do Abastecimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw2: TRLDraw
        Left = 138
        Top = 129
        Width = 1
        Height = 23
      end
      object RLDraw3: TRLDraw
        Left = 292
        Top = 127
        Width = 1
        Height = 23
      end
      object RLDraw4: TRLDraw
        Left = 421
        Top = 128
        Width = 1
        Height = 23
      end
      object RLDraw5: TRLDraw
        Left = 552
        Top = 128
        Width = 1
        Height = 23
      end
    end
    object DetailRLBand: TRLBand
      Left = 38
      Top = 193
      Width = 718
      Height = 24
      object RLDBText2: TRLDBText
        Left = 138
        Top = 5
        Width = 155
        Height = 16
        Alignment = taCenter
        DataField = 'NOME_BOMBA'
        DataSource = MovimentoForm.MovimentoDataSource
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 323
        Top = 5
        Width = 95
        Height = 16
        Alignment = taRightJustify
        DataField = 'VALOR_TOTAL'
        DataSource = MovimentoForm.MovimentoDataSource
        DisplayMask = 'R$ ##,##0.00'
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 455
        Top = 4
        Width = 96
        Height = 16
        Alignment = taRightJustify
        DataField = 'TOTAL_LITROS'
        DataSource = MovimentoForm.MovimentoDataSource
        DisplayMask = '###0.000'
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 560
        Top = 5
        Width = 155
        Height = 16
        Alignment = taCenter
        DataField = 'DATA_ABASTECIMENTO'
        DataSource = MovimentoForm.MovimentoDataSource
        Text = ''
      end
      object RLDBText1: TRLDBText
        Left = 17
        Top = 5
        Width = 104
        Height = 16
        Alignment = taCenter
        DataField = 'NOME_TANQUE'
        DataSource = MovimentoForm.MovimentoDataSource
        Text = ''
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 217
      Width = 718
      Height = 112
      BandType = btSummary
      object RLLabel9: TRLLabel
        Left = 589
        Top = 16
        Width = 126
        Height = 19
        Caption = 'Total por Litros:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText6: TRLDBText
        Left = 619
        Top = 41
        Width = 96
        Height = 16
        Alignment = taRightJustify
        DataField = 'TOTAL_LITROS'
        DataSource = MovimentoForm.TotaisDataSource
        DisplayMask = '###0.000'
        Text = ''
      end
      object RLLabel10: TRLLabel
        Left = 623
        Top = 68
        Width = 92
        Height = 19
        Caption = 'Valor Total:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText7: TRLDBText
        Left = 620
        Top = 93
        Width = 95
        Height = 16
        Alignment = taRightJustify
        DataField = 'VALOR_TOTAL'
        DataSource = MovimentoForm.TotaisDataSource
        DisplayMask = 'R$ ##,##0.00'
        Text = ''
      end
    end
  end
end
