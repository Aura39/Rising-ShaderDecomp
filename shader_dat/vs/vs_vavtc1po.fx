float4 fogParam : register(c184);
float4 g_All_Offset : register(c185);
float4 g_All_OffsetSp : register(c186);
float4x4 g_Proj : register(c4);
float4x4 g_View : register(c0);
float4x4 g_ViewInverseMatrix : register(c12);
float4x4 g_WorldMatrix : register(c16);
float4x4 g_WorldView : register(c20);
float4 g_randSeed : register(c190);
float4 g_randSeed2 : register(c191);
float4 g_refBasePos : register(c192);
float4 g_refBaseVec : register(c189);

struct VS_IN
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 normal : NORMAL;
	float4 tangent : TANGENT;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
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
	float4 r7;
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
	r3.z = dot(r2, transpose(g_WorldView)[2]);
	r0.y = r3.z + fogParam.y;
	o.texcoord1.w = r0.y * fogParam.x;
	r4 = g_All_OffsetSp.yyww;
	r5 = i.texcoord.yxyx * float4(1, -1, 1, -1) + float4(0, 1, 0, 1);
	r6 = lerp(r5, i.texcoord.xyxy, r4);
	r4 = 1 + -i.texcoord.xyxy;
	r0.yw = g_All_OffsetSp.yw;
	r5 = r0.yyyw + float4(-1, -2, -3, -1);
	r7 = lerp(r4, r6, r5.xxww);
	r0.yz = i.texcoord.yx * float2(1, -1) + 1;
	r1.yz = lerp(r0.yz, r7.xy, r5.yy);
	r4.xy = lerp(i.texcoord.xy, r1.yz, r5.zz);
	o.texcoord.xy = r4.xy * g_All_Offset.zw + g_All_Offset.xy;
	r1.yz = r0.ww + float2(-1, -2);
	r4.xy = lerp(r0.yz, r7.zw, r1.yy);
	r0.yz = -r4.xy + i.texcoord.xy;
	o.texcoord.zw = r1.zz * r0.yz + r4.xy;
	r0.y = abs(r1.x) * -0.0187293 + 0.074261;
	r0.y = r0.y * abs(r1.x) + -0.2121144;
	r0.y = r0.y * abs(r1.x) + 1.5707288;
	r0.z = -abs(r1.x) + 1;
	r0.z = 1 / sqrt(r0.z);
	r0.z = 1 / r0.z;
	r0.y = r0.z * r0.y;
	r0.z = r0.y * -2 + 3.1415927;
	r0.w = (r1.x < -r1.x) ? 1 : 0;
	r0.y = r0.z * r0.w + r0.y;
	r0.y = r0.y + -1.57;
	r0.z = (-r0.y < r0.y) ? 1 : 0;
	r0.y = (r0.y < -r0.y) ? 1 : 0;
	r0.y = -r0.y + r0.z;
	r0.zw = r2.xz + -g_randSeed2.xz;
	r1.yz = r0.zw * r0.zw;
	r1.y = r1.z + r1.y;
	r1.y = 1 / sqrt(r1.y);
	r1.y = 1 / r1.y;
	r1.y = (-r1.y < r1.y) ? 1 : 0;
	r1.y = -r1.y + 1;
	r0.zw = r0.zw + r1.yy;
	r1.yz = r0.zw * r0.zw;
	r1.y = r1.z + r1.y;
	r1.y = 1 / sqrt(r1.y);
	r0.zw = r0.zw * r1.yy;
	r0.zw = abs(r1.xx) * r0.zw;
	r0.xz = r0.xx * r0.zw;
	r0.xz = r0.xz * -r0.yy + i.normal.xz;
	r0.y = i.normal.y;
	r1.xyz = normalize(r0.xyz);
	r0.x = dot(r1.xyz, transpose(g_WorldView)[0].xyz);
	r0.y = dot(r1.xyz, transpose(g_WorldView)[1].xyz);
	r0.z = dot(r1.xyz, transpose(g_WorldView)[2].xyz);
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord3.xyz = r0.www * r0.xyz;
	r0 = i.tangent * 2 + -1;
	r0.xyz = r0.www * r0.xyz;
	r1.x = dot(r0.xyz, transpose(g_WorldView)[0].xyz);
	r1.y = dot(r0.xyz, transpose(g_WorldView)[1].xyz);
	r1.z = dot(r0.xyz, transpose(g_WorldView)[2].xyz);
	r0.x = dot(r1.xyz, r1.xyz);
	r0.x = 1 / sqrt(r0.x);
	o.texcoord2.xyz = r0.xxx * r1.xyz;
	r0.x = dot(i.position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix)[2]);
	r1.x = -transpose(g_ViewInverseMatrix)[0].w;
	r1.y = -transpose(g_ViewInverseMatrix)[1].w;
	r1.z = -transpose(g_ViewInverseMatrix)[2].w;
	o.texcoord4 = r0.xyz + r1.xyz;
	r3.x = dot(r2, transpose(g_WorldView)[0]);
	r3.y = dot(r2, transpose(g_WorldView)[1]);
	r3.w = dot(r2, transpose(g_WorldView)[3]);
	r0.xz = float2(1, -1);
	r0 = g_refBasePos.xyzx * r0.xxxz + r0.zzzx;
	r1.x = dot(r0, transpose(g_View)[0]);
	r1.y = dot(r0, transpose(g_View)[1]);
	r1.z = dot(r0, transpose(g_View)[2]);
	r0.w = dot(r0, transpose(g_View)[3]);
	r1.xyz = -r1.xyz + r3.xyz;
	r1.w = dot(r1.xyz, r1.xyz);
	r1.x = dot(g_refBaseVec.xyz, r1.xyz);
	r1.y = g_refBasePos.w * -g_refBasePos.w + r1.w;
	r1.y = r1.x * r1.x + -r1.y;
	r1.y = 1 / sqrt(r1.y);
	r1.y = 1 / r1.y;
	r1.x = -r1.y + -r1.x;
	r1.x = min(r1.x, 0);
	r0.xyz = g_refBaseVec.xyz * r1.xxx + r3.xyz;
	r1.x = dot(r0, transpose(g_Proj)[3]);
	r0.x = dot(r0, transpose(g_Proj)[1]);
	r0.y = 1 / r1.x;
	r0.x = r0.x * -r0.y + 1;
	o.texcoord3.w = r0.x * 0.5;
	r0.x = dot(r3, transpose(g_Proj)[0]);
	r0.y = dot(r3, transpose(g_Proj)[1]);
	r0.z = dot(r3, transpose(g_Proj)[2]);
	r0.w = dot(r3, transpose(g_Proj)[3]);
	o.texcoord1.xyz = r3.xyz;
	o.position = r0;
	o.texcoord8 = r0;
	o.color = i.color;
	o.texcoord2.w = i.tangent.w * 2 + -1;

	return o;
}
