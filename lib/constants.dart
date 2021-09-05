import 'package:crypto_signal_app/crypto_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

String signalsFromFirestore = '';
Map<String, dynamic> listOfID = <String, dynamic>{};
String apiKey = '176b4f97-f632-4b38-86c4-8b492a307494';
String apiCryptoUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=';
String apiBrokerUrl = '';

List<String> listOfCryptos1 = [
  '0XBTC',
  '2GIVE',
  'AAVE',
  'ABT',
  'ACT',
  'ACTN',
  'ADA',
  'ADD',
  'ADX',
  'AE',
  'AEON',
  'AGRS',
  'AION',
  'ALGO',
  'AMB',
  'AMP',
  'AMPL',
  'ANKR',
  'ANT',
  'APPC',
  'ARDR',
  'ARG',
  'ARK',
  'ARNX',
  'ARY',
  'AST',
  'ATM',
  'ATOM',
  'AUTO',
  'BAB',
  'BAL',
  'BAND',
  'BAT',
  'BAY',
  'BCC',
  'BCD',
  'BCH',
  'BCIO',
  'BCN',
  'BCO',
  'BCPT',
  'BDL',
  'BEAM',
  'BELA',
  'BIX',
  'BLK',
  'BLOCK',
  'BLZ',
  'BNB',
  'BNT',
  'BNTY',
  'BOS',
  'BPT',
  'BQ',
  'BRD',
  'BSD',
  'BSV',
  'BTC',
  'BTCD',
  'BTCP',
  'BTCZ',
  'BTDX',
  'BTG',
  'BTM',
  'BTS',
  'BTT',
  'BTX',
  'BZE',
  'CALL',
  'CC',
  'CDN',
  'CDT',
  'CHAIN',
  'CHAT',
  'CHIPS',
  'CHSB',
  'CLAM',
  'CLOAK',
  'CMM',
  'CMT',
  'CND',
  'CNX',
  'CNY',
  'COB',
  'COLX',
  'COMP',
  'CRED',
  'CRPT',
  'CRV',
  'CRW',
  'CS',
  'CTR',
  'CTXC',
  'CVC',
  'D',
  'DAI',
  'DASH',
  'DASH',
  'DAT',
  'DATA',
  'DBC',
  'DCN',
  'DCR',
  'DEEZ',
  'DENT',
  'DEW',
  'DGB',
  'DGD',
  'DLT',
  'DNT',
  'DOCK',
  'DOGE',
  'DOT',
  'DRGN',
  'DROP',
  'DTA',
  'DTH',
  'DTR',
  'EBST',
  'ECA',
  'EDG',
  'EDO',
  'EDOGE',
  'ELA',
  'ELEC',
  'ELF',
  'ELIX',
  'ELLA',
  'EMB',
  'EMC',
  'EMC2',
  'ENG',
  'ENJ',
  'ENTRP',
  'EON',
  'EOS',
  'ETC',
  'ETH',
  'ETN',
  'ETP',
  'EUR',
  'EVX',
  'EXP',
  'FAIR',
  'FCT',
  'FIL',
  'FJC',
  'FLDC',
  'FLO',
  'FLUX',
  'FSN',
  'FTC',
  'FUEL',
  'FUN',
  'GAME',
  'GAS',
  'GBP',
  'GBX',
  'GBYTE',
  'GIN',
  'GMR',
  'GNO',
  'GNT',
  'GOLD',
  'GRC',
  'GRIN',
  'GRS',
  'GRT',
  'GSC',
  'GTO',
  'GUP',
  'GUSD',
  'GVT',
  'HIGHT',
  'HNS',
  'HODL',
  'HOT',
  'HPB',
  'HT',
  'HTML',
  'HUC',
  'HUSD',
  'HUSH',
  'ICN',
  'ICP',
  'ICX',
  'IGNIS',
  'ILK',
  'INK',
  'INS',
  'ION',
  'IOP',
  'IOST',
  'IOTX',
  'IQ',
  'ITC',
  'JNT',
  'JPY',
  'KCS',
  'KIN',
  'KMD',
  'KNC',
  'KRB',
  'KSM',
  'LBC',
  'LEND',
  'LEO',
  'LINK',
  'LKK',
  'LOOM',
  'LPT',
  'LRC',
  'LSK',
  'LTC',
  'LUN',
  'MAID',
  'MANA',
  'MATIC',
  'MATIC',
  'MAX',
  'MCAP',
  'MCO',
  'MDA',
  'MDS',
  'MED',
  'MEETONE',
  'MFT',
  'MIOTA',
  'MITH',
  'MKR',
  'MLN',
  'MNX',
  'MOAC',
  'MOD',
  'MONA',
  'MSR',
  'MTH',
  'MTL',
  'MUSIC',
  'NANO',
  'NAS',
  'NAV',
  'NCASH',
  'NEBL',
  'NEO',
  'NEU',
  'NEXO',
  'NGC',
  'NIO',
  'NKN',
  'NLC2',
  'NLG',
  'NMC',
  'NMR',
  'NPXS',
  'NTBC',
  'NULS',
  'NXS',
  'NXT',
  'OAX',
  'OK',
  'OMG',
  'OMNI',
  'ONE',
  'ONG',
  'ONT',
  'OOT',
  'OST',
  'OST',
  'OX',
  'OXT',
  'PART',
  'PASC',
  'PASL',
  'PAX',
  'PAXG',
  'PAY',
  'PAYX',
  'PINK',
  'PIRL',
  'PIVX',
  'PLR',
  'POA',
  'POE',
  'POLIS',
  'POLY',
  'POT',
  'POWR',
  'PPC',
  'PPP',
  'PPT',
  'PRE',
  'PRL',
  'PURA',
  'QASH',
  'QLC',
  'QRL',
  'QSP',
  'QTUM',
  'RAP',
  'RCN',
  'RDD',
  'RDN',
  'REN',
  'REP',
  'REQ',
  'RIC',
  'RISE',
  'RLC',
  'RUB',
  'RVN',
  'RYO',
  'SAFE',
  'SAFEMOON',
  'SAI',
  'SALT',
  'SAN',
  'SAND',
  'SBD',
  'SC',
  'SHIFT',
  'SIB',
  'SIN',
  'SKL',
  'SKY',
  'SLR',
  'SLS',
  'SMART',
  'SMART',
  'SNGLS',
  'SNM',
  'SNT',
  'SNX',
  'SOC',
  'SOL',
  'SPANK',
  'SPHTX',
  'SRN',
  'STAK',
  'START',
  'STEEM',
  'STORJ',
  'STQ',
  'STX',
  'SUB',
  'SUMO',
  'SUSHI',
  'SYS',
  'TAAS',
  'TAU',
  'TBX',
  'TEL',
  'TEN',
  'TERN',
  'THETA',
  'TIX',
  'TKN',
  'TKS',
  'TNB',
  'TNC',
  'TNT',
  'TOMO',
  'TPAY',
  'TRIG',
  'TRTL',
  'TRX',
  'TUSD',
  'TZC',
  'UBQ',
  'UMA',
  'UNI',
  'UNITY',
  'USD',
  'USDC',
  'USDT',
  'UTK',
  'VERI',
  'VET',
  'VIA',
  'VIB',
  'VIBE',
  'VIVO',
  'VRC',
  'VRSC',
  'VRSC',
  'VTC',
  'VTHO',
  'WABI',
  'WAN',
  'WAVES',
  'WBTC',
  'WGR',
  'WICC',
  'WINGS',
  'WPR',
  'WTC',
  'XAS',
  'XBC',
  'XBP',
  'XBY',
  'XCP',
  'XDN',
  'XEM',
  'XIN',
  'XLM',
  'XMCC',
  'XMG',
  'XMO',
  'XMR',
  'XMY',
  'XP',
  'XPA',
  'XPM',
  'XPR',
  'XRP',
  'XTZ',
  'XUC',
  'XVC',
  'XVG',
  'YFI',
  'YOYOW',
  'ZCL',
  'ZEC',
  'ZEN',
  'ZEST',
  'ZEST',
  'ZIL',
  'ZILLA',
  'ZRX'
];
Map<String, String> listOfCryptos = {
  "0XBTC": "0xBitcoin",
  "2GIVE": "2Give",
  "AAVE": "AAVE",
  "ABT": "Arcblock",
  "ACT": "Achain",
  "ACTN": "Action Coin",
  // "ADA": "Cardano",
  "ADD": "ADD Token",
  "ADX": "AdEx",
  "AE": "Aeternity",
  "AEON": "Aeon",
  "AGRS": "Agoras Tauchain",
  "AION": "Aion",
  "ALGO": "Algorand",
  "AMB": "Ambrosus",
  "AMP": "HyperSpace (Synereo)",
  "AMPL": "Ampleforth",
  "ANKR": "Ankr Network",
  "ANT": "Aragon",
  "APPC": "AppCoins",
  "ARDR": "Ardor",
  "ARG": "Argentum",
  "ARK": "Ark",
  "ARNX": "Aeron",
  "ARY": "Block Array",
  "AST": "AirSwap",
  "ATM": "ATMChain",
  "ATOM": "Cosmos",
  "AUTO": "Cube",
  "BAB": "Bitcoin Cash ABC",
  "BAL": "Balancer",
  "BAND": "Band Protocol",
  "BAT": "Basic Attention Token",
  "BAY": "BitBay",
  "BCC": "BCC",
  "BCD": "Bitcoin Diamond",
  "BCH": "Bitcoin Cash",
  "BCIO": "Blockchain.io",
  "BCN": "Bytecoin",
  "BCO": "BananaCoin",
  "BCPT": "BlockMason Credit Protocol",
  "BDL": "Bitdeal",
  "BEAM": "Beam",
  "BELA": "Belacoin",
  "BIX": "Bibox Token",
  "BLK": "BlackCoin",
  "BLOCK": "Blocknet",
  "BLZ": "Blazecoin",
  "BNB": "Binance Coin",
  "BNT": "Bancor Network Token",
  "BNTY": "Bounty0x",
  "BOS": "BOScoin",
  "BPT": "Blockport",
  "BQ": "bitqy",
  "BRD": "Bread",
  "BSD": "BitSend",
  "BSV": "BitcoinSV",
  "BTC": "Bitcoin",
  "BTCD": "BitcoinDark",
  "BTCP": "Bitcoin Private",
  "BTCZ": "BitcoinZ",
  "BTDX": "Bitcloud",
  "BTG": "Bitcoin Gold",
  "BTM": "Bytom",
  "BTS": "BitShares",
  "BTT": "BitTorrent",
  "BTX": "Bitcore",
  "BZE": "BZEdge",
  "CALL": "Capital",
  "CC": "CoinCollect",
  "CDN": "Canada eCoin",
  "CDT": "Blox",
  "CHAIN": "Chainmakers",
  "CHAT": "ChatCoin",
  "CHIPS": "CHIPS",
  "CHSB": "SwissBorg",
  "CLAM": "Clams",
  "CLOAK": "Cloakcoin",
  "CMM": "Commercium",
  "CMT": "Comet",
  "CND": "Cindicator",
  "CNX": "Cryptonex",
  "CNY": "CNY",
  "COB": "Cobinhood",
  "COLX": "ColossusXT",
  "COMP": "Compound",
  "CRED": "Verify",
  "CRPT": "Crypterium",
  "CRV": "Curve DAO Token",
  "CRW": "Crown",
  "CS": "CREDITS",
  "CTR": "Centra",
  "CTXC": "Cortex",
  "CVC": "Civic",
  "D": "Denarius",
  "DAI": "Dai",
  "DASH": "Dash",
  "DASH": "Dash",
  "DAT": "Datum",
  "DATA": "Streamr DATAcoin",
  "DBC": "DeepBrain Chain",
  "DCN": "Dentacoin",
  "DCR": "Decred",
  "DEEZ": "DeezNuts",
  "DENT": "Dent",
  "DEW": "DEW",
  "DGB": "DigiByte",
  "DGD": "DigixDAO",
  "DLT": "Agrello",
  "DNT": "district0x",
  "DOCK": "Dock",
  "DOGE": "Dogecoin",
  "DOT": "Polkadot",
  "DRGN": "Dragonchain",
  "DROP": "Dropil",
  "DTA": "DATA",
  "DTH": "Dether",
  "DTR": "Dynamic Trading Rights",
  "EBST": "eBoost",
  "ECA": "Electra",
  "EDG": "Edgeless",
  "EDO": "Eidoo",
  "EDOGE": "EtherDoge",
  "ELA": "Elastos",
  "ELEC": "Electrify.Asia",
  "ELF": "aelf",
  "ELIX": "Elixir",
  "ELLA": "Ellaism",
  "EMB": "Emblem",
  "EMC": "EmerCoin",
  "EMC2": "Einsteinium",
  "ENG": "Enigma",
  "ENJ": "Enjin Coin",
  "ENTRP": "Hut34 Entropy",
  "EON": "EOS Network",
  "EOS": "EOS",
  "ETC": "Ethereum Classic",
  "ETH": "Ethereum",
  "ETN": "Electroneum",
  "ETP": "Metaverse ETP",
  "EUR": "EUR",
  "EVX": "Everex",
  "EXP": "Expanse",
  "FAIR": "Faircoin",
  "FCT": "Factom",
  "FIL": "Filecoin [IOU]",
  "FJC": "Fujicoin",
  "FLDC": "Foldingcoin",
  "FLO": "FLO",
  "FLUX": "Flux",
  "FSN": "FUSION",
  "FTC": "Feathercoin",
  "FUEL": "Etherparty",
  "FUN": "FunFair",
  "GAME": "GameCredits",
  "GAS": "Gas",
  "GBP": "GBP",
  "GBX": "Globitex",
  "GBYTE": "Obyte",
  "GIN": "GINcoin",
  "GMR": "Gimmer",
  "GNO": "Gnosis",
  "GNT": "Golem",
  "GOLD": "Dragonereum Gold",
  "GRC": "Gridcoin",
  "GRIN": "Grin",
  "GRS": "Groestlcoin",
  "GRT": "The Graph",
  "GSC": "Global Social Chain",
  "GTO": "Gifto",
  "GUP": "Guppy",
  "GUSD": "Gemini dollar",
  "GVT": "Genesis Vision",
  "HIGHT": "Highcoin",
  "HNS": "Handshake",
  "HODL": "HOdlcoin",
  "HOT": "Holo",
  "HPB": "High Performance \nBlockchain",
  "HT": "HOTTO",
  "HTML": "HTMLCOIN",
  "HUC": "Huntercoin",
  "HUSD": "HUSD",
  "HUSH": "Hush",
  "ICN": "Iconomi",
  "ICP": "Internet Computer",
  "ICX": "ICON",
  "IGNIS": "Ignis",
  "ILK": "Inlock Token",
  "INK": "Ink",
  "INS": "Insolar",
  "ION": "ION",
  "IOP": "Internet of People",
  "IOST": "IOStoken",
  "IOTX": "IoTeX",
  "IQ": "Everipedia",
  "ITC": "IoT Chain",
  "JNT": "Jibrel Network",
  "JPY": "JPY",
  "KCS": "KuCoin Shares",
  "KIN": "Kin",
  "KMD": "Komodo",
  "KNC": "Kyber Network",
  "KRB": "Karbo",
  "KSM": "Kusama",
  "LBC": "LBRY Credits",
  "LEND": "ETHLend",
  "LEO": "Unus Sed LEO",
  "LINK": "ChainLink",
  "LKK": "Lykke",
  "LOOM": "Loom Network",
  "LPT": "Livepeer Token",
  "LRC": "Loopring",
  "LSK": "Lisk",
  "LTC": "Litecoin",
  "LUN": "Lunyr",
  "MAID": "MaidSafeCoin",
  "MANA": "Decentraland",
  "MATIC": "Polygon",
  "MATIC": "Polygon",
  "MAX": "MAX Token",
  "MCAP": "MCAP",
  "MCO": "Crypto.com",
  "MDA": "Moeda Loyalty Points",
  "MDS": "MediShares",
  "MED": "Medibloc",
  "MEETONE": "MEET.ONE",
  "MFT": "Mainframe",
  "MIOTA": "IOTA",
  "MITH": "Mithril",
  "MKR": "Maker",
  "MLN": "Melon",
  "MNX": "MinexCoin",
  "MOAC": "MOAC",
  "MOD": "Modum",
  "MONA": "MonaCoin",
  "MSR": "Masari",
  "MTH": "Monetha",
  "MTL": "Metal",
  "MUSIC": "Musicoin",
  "NANO": "Nano",
  "NAS": "Nebulas",
  "NAV": "NavCoin",
  "NCASH": "Nucleus Vision",
  "NEBL": "Neblio",
  "NEO": "NEO",
  "NEU": "Neumark",
  "NEXO": "Nexo",
  "NGC": "NAGA",
  "NIO": "Autonio",
  "NKN": "NKN",
  "NLC2": "NoLimitCoin",
  "NLG": "Gulden",
  "NMC": "Namecoin",
  "NMR": "Numeraire",
  "NPXS": "Pundi X",
  "NTBC": "Note Blockchain",
  "NULS": "Nuls",
  "NXS": "Nexus",
  "NXT": "NXT",
  "OAX": "OpenANX",
  "OK": "OKCash",
  "OMG": "OMG Network",
  "OMNI": "Omni",
  "ONE": "Harmony",
  "ONG": "SoMee.Social",
  "ONT": "Ontology",
  "OOT": "Utrum",
  "OST": "OST",
  "OST": "OST",
  "OX": "OX Fina",
  "OXT": "Orchid",
  "PART": "Particl",
  "PASC": "Pascalcoin",
  "PASL": "Pascal Lite",
  "PAX": "PAX Token",
  "PAXG": "PAX Gold",
  "PAY": "TenX",
  "PAYX": "Paypex",
  "PINK": "Pinkcoin",
  "PIRL": "Pirl",
  "PIVX": "PIVX",
  "PLR": "Pillar",
  "POA": "POA Network",
  "POE": "Po.et",
  "POLIS": "Polis",
  "POLY": "Polymath Network",
  "POT": "Potcoin",
  "POWR": "Power Ledger",
  "PPC": "Peercoin",
  "PPP": "PayPie",
  "PPT": "Populous",
  "PRE": "Presearch",
  "PRL": "Oyster",
  "PURA": "Pura",
  "QASH": "QASH",
  "QLC": "QLC Chain",
  "QRL": "Quantum Resistant Ledger",
  "QSP": "Quantstamp",
  "QTUM": "Qtum",
  "RAP": "Rapture",
  "RCN": "Rcoin",
  "RDD": "Reddcoin",
  "RDN": "Raiden Network Token",
  "REN": "Ren",
  "REP": "Augur",
  "REQ": "Request",
  "RIC": "Riecoin",
  "RISE": "Rise",
  "RLC": "iExec RLC",
  "RUB": "RUB",
  "RVN": "Ravencoin",
  "RYO": "Ryo Currency",
  "SAFE": "Safe",
  "SAFEMOON": "SafeMoon",
  "SAI": "Single Collateral DAI",
  "SALT": "SALT",
  "SAN": "Santiment Network Token",
  "SAND": "The Sandbox",
  "SBD": "Steem Dollars",
  "SC": "Siacoin",
  "SHIFT": "Shift",
  "SIB": "SIBCoin",
  "SIN": "SINOVATE",
  "SKL": "SKALE Network",
  "SKY": "Skycoin",
  "SLR": "Solarcoin",
  "SLS": "SaluS",
  "SMART": "SmartCash",
  "SMART": "SmartCash",
  "SNGLS": "SingularDTV",
  "SNM": "SONM",
  "SNT": "Status",
  "SNX": "Synthetix",
  "SOC": "All Sports",
  "SOL": "Solana",
  "SPANK": "SpankChain",
  "SPHTX": "SophiaTX",
  "SRN": "Sirin Labs Token",
  "STAK": "STRAKS",
  "START": "Startcoin",
  "STEEM": "Steem",
  "STORJ": "Storj",
  "STQ": "Storiqa",
  "STX": "Stacks",
  "SUB": "Substratum",
  "SUMO": "Sumokoin",
  "SUSHI": "SushiSwap",
  "SYS": "Syscoin",
  "TAAS": "TaaS",
  "TAU": "Lamden",
  "TBX": "Tokenbox",
  "TEL": "Telcoin",
  "TEN": "Tokenomy",
  "TERN": "Ternio",
  "THETA": "Theta Network",
  "TIX": "Blocktix",
  "TKN": "TokenCard",
  "TKS": "Tokes Platform",
  "TNB": "Time New Bank",
  "TNC": "Trinity Network Credit",
  "TNT": "Tierion",
  "TOMO": "TomoChain",
  "TPAY": "TokenPay",
  "TRIG": "Triggers",
  "TRTL": "TurtleCoin",
  "TRX": "TRON",
  "TUSD": "TrueUSD",
  "TZC": "TrezarCoin",
  "UBQ": "Ubiq",
  "UMA": "UMA",
  "UNI": "Uniswap",
  "UNITY": "SuperNET",
  "USD": "USD",
  "USDC": "USD Coin",
  "USDT": "Tether",
  "UTK": "UTRUST",
  "VERI": "Veritaseum",
  "VET": "VeChain",
  "VIA": "Viacoin",
  "VIB": "Viberate",
  "VIBE": "VIBE",
  "VIVO": "VIVO",
  "VRC": "VeriCoin",
  "VRSC": "VerusCoin",
  "VRSC": "VerusCoin",
  "VTC": "Vertcoin",
  "VTHO": "VeThor Token",
  "WABI": "Tael",
  "WAN": "Wanchain",
  "WAVES": "Waves",
  "WBTC": "Wrapped Bitcoin",
  "WGR": "Wagerr",
  "WICC": "WaykiChain",
  "WINGS": "Wings",
  "WPR": "WePower",
  "WTC": "Waltonchain",
  "XAS": "Asch",
  "XBC": "Bitcoin Plus",
  "XBP": "BlitzPredict",
  "XBY": "XtraBYtes",
  "XCP": "Counterparty",
  "XDN": "DigitalNote",
  "XEM": "NEM",
  "XIN": "Infinity Economics",
  "XLM": "Stellar",
  "XMCC": "Monoeci",
  "XMG": "Magi",
  "XMO": "Monero Original",
  "XMR": "Monero",
  "XMY": "Myriad",
  "XP": "XP",
  "XPA": "XPA",
  "XPM": "Primecoin",
  "XPR": "Proton",
  "XRP": "XRP",
  "XTZ": "Tezos",
  "XUC": "Exchange Union",
  "XVC": "Vcash",
  "XVG": "Verge",
  "YFI": "yearn.finance",
  "YOYOW": "YOYOW",
  "ZCL": "Zclassic",
  "ZEC": "Zcash",
  "ZEN": "Horizen",
  "ZEST": "Zest",
  "ZEST": "Zest",
  "ZIL": "Zilliqa",
  "ZILLA": "Chainzilla",
  "ZRX": "0x",
};
bool showOndoarding = false;
String termsAndConditionsText =
    'www.cyptosignal.io\n\nThis disclaimer and these terms and conditions of use tell you how the Site is managed and how you are protected when you are using our Site, Application and/or our Services.\n\nThese terms and conditions of use and disclaimer, together with the terms of the Privacy Policy available at www.cyptosignal.io ”) (collectively, these “\nRisk Warning: Trading Cryptos is potentially full of high risk and may not be suitable for all investors. The high level of leverage can work both for and against traders. Before any investment you need to carefully consider your targets, previous experience, and risk level. Trading can result in the loss of your money, as a result, you are expressly cautioned that you should never invest or trade with money that you cannot afford to lose. Last Modified: May 1 2021”) form an integral part of any use of the Site or our Services, as such terms are defined below, and you agree to be bound by them and to comply with all applicable laws and regulations regarding your use of the Site and the Services and you acknowledge that even though these Terms of Use are electronic and are not physically signed by you and the Company, these terms of use constitute a binding and enforceable legal contract between the Company and you.\nRisk Warning: Trading Cryptos is potentially full of high risk and may not be suitable for all investors. The high level of leverage can work both for and against traders. Before any investment you need to carefully consider your targets, previous experience, and risk level. Trading can result in the loss of your money, as a result, you are expressly cautioned that you should never invest or trade with money that you cannot afford to lose.\nIF YOU DO NOT AGREE WITH THESE TERMS OF USE, YOU SHOULD LEAVE THE SITE IMMEDIATELY.\nDISCLAIMER: The content of this website is intended to convey general information only. This website/app (hereinafter the “website”) does not provide legal, investment, tax, etc. advice. You should not treat any information as a call to make any particular decision regarding Crypto usage, legal matters, investments, taxes, exchange usage, wallet usage, etc. We strongly suggest seeking advice from your own financial, investment, tax, or legal adviser. Neither this website nor its parent companies accept any responsibility for any loss, damage, or inconvenience caused as a result of reliance on information published on, or linked to the website.\nNO FINANCIAL ADVICE \nThe Information on this website is provided for education and informational purposes only, without any express or implied warranty of any kind, including warranties of accuracy, completeness, or fitness for any particular purpose. The Information contained in or provided from or through this website is not intended to be and does not constitute financial advice, investment advice, trading advice or any other advice. The Information on this website and provided from or through this website is general in nature and is not specific to you the User or anyone else. You should not make any decision, financial, investment, trading or otherwise, based on any of the information presented on this website without undertaking independent due diligence and consultation with a professional broker or financial advisory. You understand that you are using any and all Information available on or through this website at your own risk. The information provided on this website does not constitute investment advice, financial advice, trading advice or any other sort of advice and you should not treat any of the website’s content as such. The Website does not recommend that any Crypto should be bought, sold or held by you and nothing on this website should be taken as an offer to buy, sell or hold a Crypto. Do conduct your own due-diligence and consult your financial advisory before making any investment decision.';
String privacyAndPolicyText =
    'Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla.\n\nBla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla.\n\nBla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla.';
Color buttonGradientStart = const Color.fromRGBO(84, 122, 255, 1);
Color buttonGradientEnd = const Color.fromRGBO(65, 61, 255, 1);
Color textGreen = const Color.fromRGBO(0, 255, 41, 1);
Color textRed = const Color.fromRGBO(255, 97, 97, 1);
Color textBlue = const Color.fromRGBO(51, 182, 255, 1);
Color textDefault = const Color.fromRGBO(252, 252, 252, 1);
Color cardBackground = const Color.fromRGBO(34, 36, 51, 0.8);
Color textShaded = const Color.fromRGBO(252, 252, 252, 0.4);
Color checkboxColor = const Color.fromRGBO(71, 71, 81, 1);
Color textFieldBorderColor = const Color.fromRGBO(255, 255, 255, 0.4);
Color textFocused = const Color.fromRGBO(252, 252, 252, 1);
Color svgPicturesColor = const Color.fromRGBO(30, 30, 32, 1);
Color signalWidgetShaded = const Color.fromRGBO(252, 252, 252, 0.64);
Color textPlaceholder = const Color.fromRGBO(255, 255, 255, 0.2);
Color textBlack = const Color.fromRGBO(26, 27, 39, 1);
Color bottomNavBarColor = const Color.fromRGBO(122, 124, 148, 1);
Color toggleButtonBorderColor = const Color.fromRGBO(255, 255, 255, 0.1);
TextStyle textStyleSignalDefault = TextStyle(
    color: textDefault,
    fontSize: 22.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textStyleSignalGreen = TextStyle(
    color: textGreen,
    fontSize: 22.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textStyleSignalRed = TextStyle(
    color: textRed,
    fontSize: 22.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textStyleSignalShaded = TextStyle(
    color: signalWidgetShaded,
    fontSize: 14.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textStyleSignalWidget = TextStyle(
    color: signalWidgetShaded,
    fontSize: 12.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textStyleHeader = TextStyle(
    color: textDefault,
    fontSize: 24.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textStyleSuperHeader = TextStyle(
    color: textDefault,
    fontSize: 32.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textStyleHeaderGreen = TextStyle(
    color: textGreen,
    fontSize: 24.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textStyleHeaderRed = TextStyle(
    color: textRed,
    fontSize: 24.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle richTextHeader = TextStyle(
    color: textDefault,
    fontSize: 20.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w700);
TextStyle richTextRegular = TextStyle(
    color: textDefault,
    fontSize: 16.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textButtonStyle = TextStyle(
    color: textDefault,
    fontSize: 14.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textGainGreen = TextStyle(
    color: textGreen,
    fontSize: 14.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textGainRed = TextStyle(
    color: textRed,
    fontSize: 14.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textShadedStyle = TextStyle(
    color: textShaded,
    fontSize: 14.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500);
TextStyle textFieldStyle = TextStyle(
  color: textPlaceholder,
  fontSize: 14.sp,
  fontFamily: 'DMSans',
  fontWeight: FontWeight.w500,
);
TextStyle toggleButtonStyle = TextStyle(
    fontSize: 14.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w400);
TextStyle errorStyle = TextStyle(
    fontSize: 12.sp,
    color: const Color.fromRGBO(167, 43, 47, 1),
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w600);
TextStyle bottomTabBarStyle = TextStyle(
    color: bottomNavBarColor,
    fontSize: 14.sp,
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w400);
TextStyle textStyleShaded = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  fontFamily: 'DMSans',
  color: textShaded,
);
TextStyle textStyleWhite = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  fontFamily: 'DMSans',
  color: textDefault,
);
TextStyle textStyleSuperWhite = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.w500,
  fontFamily: 'DMSans',
  color: textDefault,
);
ThemeData appThemeData = ThemeData(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
);
ThemeData textFieldThemeData = ThemeData(
  textTheme: TextTheme(
    subtitle1: textButtonStyle,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: toggleButtonBorderColor,

    // errorStyle: errorStyle,
    filled: true,
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: toggleButtonBorderColor,
        width: 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: toggleButtonBorderColor,
        width: 1.0,
      ),
    ),
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: textFieldBorderColor)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.w),
    ),
    hintStyle: textFieldStyle,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: textDefault,
  ),
);
RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
