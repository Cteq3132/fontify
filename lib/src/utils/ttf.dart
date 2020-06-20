import 'dart:typed_data';

const String kHeadTag = 'head';
const String kGSUBTag = 'GSUB';
const String kOS2Tag = 'OS/2';
const String kCmapTag = 'cmap';
const String kGlyfTag = 'glyf';
const String kHheaTag = 'hhea';
const String kHmtxTag = 'hmtx';
const String kLocaTag = 'loca';
const String kMaxpTag = 'maxp';
const String kNameTag = 'name';
const String kPostTag = 'post';

final _longDateTimeStart = DateTime.parse('1904-01-01T00:00:00.000Z');

String convertTagToString(Uint8List bytes) => 
  String.fromCharCodes(bytes);

DateTime getDateTime(int seconds) => 
  _longDateTimeStart.add(Duration(seconds: seconds));

int getLongDateTime(DateTime dateTime) => 
  dateTime.difference(_longDateTimeStart).inSeconds;

bool checkBitMask(int value, int mask) => 
  (value & mask) == mask;

extension TTFByteDateExt on ByteData {
  int getFixed(int offset) => getUint16(offset);
  int getFWord(int offset) => getInt16(offset);
  int getUFWord(int offset) => getUint16(offset);
}

extension TTFStringExt on String {
  String getAsciiPrintable() =>
    replaceAll(RegExp(r'([^\x00-\x7E]|[\(\[\]\(\)\{\}<>\/%])'), '');
}


class Revision {
  const Revision(int major, int minor) : 
    major = major ?? 0, 
    minor = minor ?? 0;

  factory Revision.fromInt32(int revision) {
    return Revision((revision >> 16) & 0xFFFF, revision & 0xFFFF);
  }

  final int major;
  final int minor;

  int get int32value => major * 0x10000 + minor;
}