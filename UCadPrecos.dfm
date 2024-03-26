object CadastroPrecosForm: TCadastroPrecosForm
  Left = 0
  Top = 0
  Caption = 'Cadastro Pre'#231'os/Taxas'
  ClientHeight = 467
  ClientWidth = 734
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object TanquesPanel: TPanel
    Left = 0
    Top = 0
    Width = 734
    Height = 153
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 59
      Width = 96
      Height = 15
      Caption = 'Relacionar Tanque'
    end
    object Label2: TLabel
      Left = 168
      Top = 61
      Width = 28
      Height = 15
      Caption = 'Ativo'
    end
    object CodPrecoLabeledEdit: TLabeledEdit
      Left = 16
      Top = 30
      Width = 121
      Height = 23
      EditLabel.Width = 80
      EditLabel.Height = 15
      EditLabel.Caption = 'C'#243'digo Bomba'
      ReadOnly = True
      TabOrder = 0
      Text = ''
    end
    object DescricaoLabeledEdit: TLabeledEdit
      Left = 168
      Top = 32
      Width = 529
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 51
      EditLabel.Height = 15
      EditLabel.Caption = 'Descri'#231#227'o'
      TabOrder = 1
      Text = ''
    end
    object SalvarButton: TButton
      Left = 541
      Top = 123
      Width = 75
      Height = 25
      Caption = '&Salvar'
      TabOrder = 2
      OnClick = SalvarButtonClick
    end
    object DeletarButton: TButton
      Left = 622
      Top = 122
      Width = 75
      Height = 25
      Caption = '&Deletar'
      TabOrder = 3
      OnClick = DeletarButtonClick
    end
    object IncluirButton: TButton
      Left = 460
      Top = 122
      Width = 75
      Height = 25
      Caption = '&Incluir'
      TabOrder = 4
      OnClick = IncluirButtonClick
    end
    object TipoComboBox: TComboBox
      Left = 16
      Top = 80
      Width = 121
      Height = 23
      ItemIndex = 0
      TabOrder = 5
      Text = 'Gasolina'
      Items.Strings = (
        'Gasolina'
        'Diesel'
        'Etanol')
    end
    object AtivoComboBox: TComboBox
      Left = 168
      Top = 80
      Width = 81
      Height = 23
      ItemIndex = 0
      TabOrder = 6
      Text = 'SIM'
      Items.Strings = (
        'SIM'
        'N'#194'O'
        '')
    end
    object ImpostoLabeledEdit: TLabeledEdit
      Left = 264
      Top = 80
      Width = 73
      Height = 23
      EditLabel.Width = 57
      EditLabel.Height = 15
      EditLabel.Caption = 'Imposto %'
      Enabled = False
      ReadOnly = True
      TabOrder = 7
      Text = '13,00'
    end
    object PrecoLabeledEdit: TLabeledEdit
      Left = 360
      Top = 80
      Width = 104
      Height = 23
      EditLabel.Width = 90
      EditLabel.Height = 15
      EditLabel.Caption = 'Valor por Litro R$'
      TabOrder = 8
      Text = ''
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 153
    Width = 735
    Height = 312
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object TanquesDBGrid: TDBGrid
      Left = 0
      Top = 0
      Width = 735
      Height = 312
      Align = alCustom
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = PrecosDataSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = TanquesDBGridDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'COD_PRECOS'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECOS_LITRO'
          Title.Caption = 'Pre'#231'o por Litro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TIPO'
          Title.Caption = 'Tipo'
          Width = 115
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TAXA'
          Title.Caption = 'Imposto'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_INCLUSAO'
          Title.Caption = 'Data de Inclus'#227'o'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_ATUALIZACAO'
          Title.Caption = 'Data de Atualiza'#231#227'o'
          Visible = True
        end>
    end
  end
  object PrecosFDQuery: TFDQuery
    Connection = FrmPrincipal.FDConnection
    SQL.Strings = (
      
        'SELECT COD_PRECOS, DESCRICAO, TIPO, PRECOS_LITRO, TAXA, ATIVO, D' +
        'ATA_INCLUSAO, DATA_ATUALIZACAO  FROM  PRECOS')
    Left = 296
    Top = 104
    object PrecosFDQueryCOD_PRECOS: TIntegerField
      FieldName = 'COD_PRECOS'
      Origin = 'COD_PRECOS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object PrecosFDQueryDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
    object PrecosFDQueryTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
    end
    object PrecosFDQueryPRECOS_LITRO: TFMTBCDField
      FieldName = 'PRECOS_LITRO'
      Origin = 'PRECOS_LITRO'
      DisplayFormat = 'R$ ##,##0.00'
      Precision = 18
      Size = 2
    end
    object PrecosFDQueryTAXA: TFMTBCDField
      FieldName = 'TAXA'
      Origin = 'TAXA'
      DisplayFormat = '##0.00%'
      Precision = 18
      Size = 2
    end
    object PrecosFDQueryATIVO: TStringField
      FieldName = 'ATIVO'
      Origin = 'ATIVO'
      Size = 10
    end
    object PrecosFDQueryDATA_INCLUSAO: TDateField
      FieldName = 'DATA_INCLUSAO'
      Origin = 'DATA_INCLUSAO'
    end
    object PrecosFDQueryDATA_ATUALIZACAO: TDateField
      FieldName = 'DATA_ATUALIZACAO'
      Origin = 'DATA_ATUALIZACAO'
    end
  end
  object PrecosDataSource: TDataSource
    DataSet = PrecosFDQuery
    Left = 384
    Top = 104
  end
  object CodigoFDQuery: TFDQuery
    Connection = FrmPrincipal.FDConnection
    Left = 192
    Top = 104
    object LargeintField1: TLargeintField
      FieldName = 'COD_PRECOS'
    end
  end
end
