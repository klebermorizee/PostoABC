object CadastroBombasForm: TCadastroBombasForm
  Left = 0
  Top = 0
  Caption = 'Cadastro Bombas'
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
    object CodBombasLabeledEdit: TLabeledEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 23
      Alignment = taRightJustify
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
    object DBLookupComboBox: TDBLookupComboBox
      Left = 16
      Top = 80
      Width = 145
      Height = 23
      KeyField = 'COD_TANQUE'
      ListField = 'DESCRICAO'
      ListSource = TanquesDataSource
      TabOrder = 5
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
      DataSource = BombaDataSource
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
          FieldName = 'COD_BOMBA'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 559
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COD_TANQUE'
          Title.Caption = 'Tanque'
          Visible = True
        end>
    end
  end
  object BombaFDQuery: TFDQuery
    Connection = FrmPrincipal.FDConnection
    SQL.Strings = (
      'SELECT COD_BOMBA,DESCRICAO,COD_TANQUE FROM BOMBAS')
    Left = 296
    Top = 104
    object BombaFDQueryCOD_BOMBA: TIntegerField
      FieldName = 'COD_BOMBA'
      Origin = 'COD_BOMBA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object BombaFDQueryDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 45
    end
    object BombaFDQueryCOD_TANQUE: TIntegerField
      FieldName = 'COD_TANQUE'
      Origin = 'COD_TANQUE'
    end
  end
  object BombaDataSource: TDataSource
    DataSet = BombaFDQuery
    Left = 384
    Top = 104
  end
  object CodigoFDQuery: TFDQuery
    Connection = FrmPrincipal.FDConnection
    SQL.Strings = (
      
        'SELECT COD_TANQUE,DESCRICAO,TIPO,CAPACIDADE_LITROS,TOTAL_LITROS ' +
        'FROM TANQUES')
    Left = 192
    Top = 104
    object LargeintField1: TLargeintField
      FieldName = 'COD_BOMBA'
    end
  end
  object TanquesDataSource: TDataSource
    DataSet = TanquesFDQuery
    Left = 480
    Top = 72
  end
  object TanquesFDQuery: TFDQuery
    Connection = FrmPrincipal.FDConnection
    SQL.Strings = (
      'SELECT DESCRICAO,COD_TANQUE FROM TANQUES')
    Left = 336
    Top = 72
    object TanquesFDQueryDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 150
    end
    object TanquesFDQueryCOD_TANQUE: TIntegerField
      FieldName = 'COD_TANQUE'
      Origin = 'COD_TANQUE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
end
