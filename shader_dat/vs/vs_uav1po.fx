float4 fogParam : register(c184);
float4 g_All_Offset : register(c185);
float4 g_All_OffsetSp : register(c186);
float4x4 g_Proj : register(c4);
float4x4 g_WorldView : register(c20);

struct VS_IN
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord8 : TEXCOORD8;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.z = dot(r0, transpose(g_WorldView)[2]);
	r2.x = r1.z + fogParam.y;
	o.texcoord1.w = r2.x * fogParam.x;
	r2 = g_All_OffsetSp.yyww;
	r3 = i.texcoord.yxyx * float4(1, -1, 1, -1) + float4(0, 1, 0, 1);
	r4 = lerp(r3, i.texcoord.xyxy, r2);
	r2 = 1 + -i.texcoord.xyxy;
	r3.yw = g_All_OffsetSp.yw;
	r5 = r3.yyyw + float4(-1, -2, -3, -1);
	r6 = lerp(r2, r4, r5.xxww);
	r2.xy = i.texcoord.yx * float2(-1, 1) + float2(1, 0);
	r3.xy = lerp(r2.xy, r6.xy, r5.yy);
	r2.zw = lerp(i.texcoord.xy, r3.xy, r5.zz);
	o.texcoord.xy = r2.zw * g_All_Offset.zw + g_All_Offset.xy;
	r2.zw = r3.ww + float2(-1, -2);
	r3.xy = lerp(r2.xy, r6.zw, r2.zz);
	r2.xy = -r3.xy + i.texcoord.xy;
	o.texcoord.zw = r2.ww * r2.xy + r3.xy;
	r1.w = dot(r0, transpose(g_WorldView)[3]);
	r1.x = dot(r0, transpose(g_WorldView)[0]);
	r1.y = dot(r0, transpose(g_WorldView)[1]);
	r0.x = dot(r1, transpose(g_Proj)[0]);
	r0.y = dot(r1, transpose(g_Proj)[1]);
	r0.z = dot(r1, transpose(g_Proj)[2]);
	r0.w = dot(r1, transpose(g_Proj)[3]);
	o.texcoord1.xyz = r1.xyz;
	o.position = r0;
	o.texcoord8 = r0;
	o.color = i.color;

	return o;
}
