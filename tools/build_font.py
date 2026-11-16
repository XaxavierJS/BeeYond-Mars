from pathlib import Path
from fontTools.fontBuilder import FontBuilder
from fontTools.pens.ttGlyphPen import TTGlyphPen
from PIL import Image
import re,json,sys,unicodedata
p=Path(sys.argv[1]);d=json.loads(re.sub(r',\s*([}\]])',r'\1', (p/'spr_font.yy').read_text()))
bitmaps={}
for n,f in enumerate(d['frames']):
 im=Image.open(p/(f['name']+'.png')).convert('RGBA');bitmaps[chr(n+32)]=[(x,y) for y in range(im.height) for x in range(im.width) if im.getpixel((x,y))[3]>128]
for char in 'áéíóúüñÁÉÍÓÚÜÑ':
 base=unicodedata.normalize('NFD',char)[0]; pts=list(bitmaps[base]);pts.extend([(2,-2),(3,-3)] if char not in 'ñÑüÜ' else [(1,-2),(3,-2)]);bitmaps[char]=pts
for a,b in [('—','-'),('–','-'),('’',"'"),('‘',"'"),('“','"'),('”','"'),('·','.'),('−','-')]:bitmaps[a]=bitmaps[b]
fb=FontBuilder(1000,isTTF=True); names={c:'uni%04X'%ord(c) for c in bitmaps};order=['.notdef']+list(names.values());fb.setupGlyphOrder(order);glyphs={};metrics={}
for c,name in [('', '.notdef')]+list(names.items()):
 pen=TTGlyphPen(None)
 for x,y in bitmaps.get(c,[]):
  x*=100;y=(8-y)*100;pen.moveTo((x,y));pen.lineTo((x,y+100));pen.lineTo((x+100,y+100));pen.lineTo((x+100,y));pen.closePath()
 glyphs[name]=pen.glyph();metrics[name]=(700,0)
fb.setupCharacterMap({ord(c):n for c,n in names.items()});fb.setupGlyf(glyphs);fb.setupHorizontalMetrics(metrics);fb.setupHorizontalHeader(ascent=1200,descent=-200);fb.setupNameTable({'familyName':'Aurelia Pixel','styleName':'Regular','uniqueFontIdentifier':'AureliaPixelV5','fullName':'Aurelia Pixel','psName':'AureliaPixel'});fb.setupOS2(sTypoAscender=1200,sTypoDescender=-200,usWinAscent=1200,usWinDescent=200);fb.setupPost();fb.setupMaxp();fb.save('/workspace/sites/beeyond-mars-aurelia/dist/assets/aurelia-pixel.ttf')
