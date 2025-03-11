float4 fogParam : register(c184);
float4 g_All_Offset : register(c185);
float4 g_All_OffsetSp : register(c186);
float4x4 g_Proj : register(c4);
float4x4 g_WorldView : register(c20);
float4 g_randSeed : register(c190);
float4 g_randSeed2 : register(c191);

struct VS_IN
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 normal : NORMAL;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
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
	r0.x = dot(i.position.xyz, i.position.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.x = 1 / r0.x;
	r0.x = r0.x * g_randSeed.z;
	r0.x = frac(r0.x);
	r0.x = r0.x + 0.5;
	r0.yzw = -g_randSeed2.xyz + i.position.xyz;
	r0.y = dot(r0.yzw, r0.yzw);
	r0.y = 1 / sqrt(r0.y);
	r0.y = 1 / r0.y;
	r0.y = g_randSeed.y * -r0.y + g_randSeed.w;
	r0.y = r0.y * 0.15915494 + 0.5;
	r0.y = frac(r0.y);
	r0.y = r0.y * 6.2831855 + -3.1415927;
	sincos(r0.y, r1.x, r1.x);
	r0.y = r1.x + 1;
	r0.y = r0.y * g_randSeed.x;
	r0.x = r0.x * r0.y;
	r2.xyz = i.position.xyz;
	r2.xyz = i.normal.xyz * r0.xxx + r2.xyz;
	r2.w = 1;
	r3.w = dot(r2, transpose(g_WorldView)[3]);
	r3.x = dot(r2, transpose(g_WorldView)[0]);
	r3.y = dot(r2, transpose(g_WorldView)[1]);
	r3.z = dot(r2, transpose(g_WorldView)[2]);
	r0.yz = r2.xz + -g_randSeed2.xz;
	o.position.x = dot(r3, transpose(g_Proj)[0]);
	o.position.y = dot(r3, transpose(g_Proj)[1]);
	o.position.z = dot(r3, transpose(g_Proj)[2]);
	o.position.w = dot(r3, transpose(g_Proj)[3]);
	o.texcoord1.xyz = r3.xyz;
	r0.w = r3.z + fogParam.y;
	o.texcoord1.w = r0.w * fogParam.x;
	r2 = g_All_OffsetSp.yyww;
	r3 = i.texcoord.yxyx * float4(1, -1, 1, -1) + float4(0, 1, 0, 1);
	r4 = lerp(r3, i.texcoord.xyxy, r2);
	r2 = 1 + -i.texcoord.xyxy;
	r1.yw = g_All_OffsetSp.yw;
	r3 = r1.yyyw + float4(-1, -2, -3, -1);
	r5 = lerp(r2, r4, r3.xxww);
	r1.yz = i.texcoord.yx * float2(1, -1) + 1;
	r2.xy = lerp(r1.yz, r5.xy, r3.yy);
	r4.xy = lerp(i.texcoord.xy, r2.xy, r3.zz);
	o.texcoord.xy = r4.xy * g_All_Offset.zw + g_All_Offset.xy;
	r2.xy = r1.ww + float2(-2, -3);
	r3.xy = lerp(r1.yz, r5.zw, r2.xx);
	r1.yz = -r3.xy + i.texcoord.xy;
	o.texcoord.zw = r2.yy * r1.yz + r3.xy;
	r0.w = abs(r1.x) * -0.0187293 + 0.074261;
	r0.w = r0.w * abs(r1.x) + -0.2121144;
	r0.w = r0.w * abs(r1.x) + 1.5707288;
	r1.y = -abs(r1.x) + 1;
	r1.y = 1 / sqrt(r1.y);
	r1.y = 1 / r1.y;
	r0.w = r0.w * r1.y;
	r1.y = r0.w * -2 + 3.1415927;
	r1.z = (r1.x < -r1.x) ? 1 : 0;
	r0.w = r1.y * r1.z + r0.w;
	r0.w = r0.w + -1.57;
	r1.y = (-r0.w < r0.w) ? 1 : 0;
	r0.w = (r0.w < -r0.w) ? 1 : 0;
	r0.w = -r0.w + r1.y;
	r1.yz = r0.yz * r0.yz;
	r1.y = r1.z + r1.y;
	r1.y = 1 / sqrt(r1.y);
	r1.y = 1 / r1.y;
	r1.y = (-r1.y < r1.y) ? 1 : 0;
	r1.y = -r1.y + 1;
	r0.yz = r0.yz + r1.yy;
	r1.yz = r0.yz * r0.yz;
	r1.y = r1.z + r1.y;
	r1.y = 1 / sqrt(r1.y);
	r0.yz = r0.yz * r1.yy;
	r0.yz = abs(r1.xx) * r0.yz;
	r0.xy = r0.xx * r0.yz;
	r0.xz = r0.xy * -r0.ww + i.normal.xz;
	r0.y = i.normal.y;
	r1.xyz = normalize(r0.xyz);
	r0.x = dot(r1.xyz, transpose(g_WorldView)[0].xyz);
	r0.y = dot(r1.xyz, transpose(g_WorldView)[1].xyz);
	r0.z = dot(r1.xyz, transpose(g_WorldView)[2].xyz);
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord3 = r0.www * r0.xyz;
	o.color = i.color;

	return o;
}
