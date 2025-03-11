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
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.w = dot(r0, transpose(g_WorldView)[3]);
	r1.x = dot(r0, transpose(g_WorldView)[0]);
	r1.y = dot(r0, transpose(g_WorldView)[1]);
	r1.z = dot(r0, transpose(g_WorldView)[2]);
	o.position.x = dot(r1, transpose(g_Proj)[0]);
	o.position.y = dot(r1, transpose(g_Proj)[1]);
	o.position.z = dot(r1, transpose(g_Proj)[2]);
	o.position.w = dot(r1, transpose(g_Proj)[3]);
	o.texcoord1.xyz = r1.xyz;
	r0.x = r1.z + fogParam.y;
	o.texcoord1.w = r0.x * fogParam.x;
	r0 = g_All_OffsetSp.yyww;
	r1 = i.texcoord.yxyx * float4(1, -1, 1, -1) + float4(0, 1, 0, 1);
	r2 = lerp(r1, i.texcoord.xyxy, r0);
	r0 = 1 + -i.texcoord.xyxy;
	r1.yw = g_All_OffsetSp.yw;
	r3 = r1.yyyw + float4(-1, -2, -3, -1);
	r4 = lerp(r0, r2, r3.xxww);
	r0.xy = i.texcoord.yx * float2(-1, 1) + float2(1, 0);
	r1.xy = lerp(r0.xy, r4.xy, r3.yy);
	r0.zw = lerp(i.texcoord.xy, r1.xy, r3.zz);
	o.texcoord.xy = r0.zw * g_All_Offset.zw + g_All_Offset.xy;
	r0.zw = r1.ww + float2(-1, -2);
	r1.xy = lerp(r0.xy, r4.zw, r0.zz);
	r0.xy = -r1.xy + i.texcoord.xy;
	o.texcoord.zw = r0.ww * r0.xy + r1.xy;
	o.color = i.color;

	return o;
}
