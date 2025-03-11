float4 g_All_Offset_vs : register(c185);
float4 g_SkyHemisphereColor : register(c189);
float4 g_ambientRate : register(c191);
float4 g_normalmapRate_vs : register(c186);
float4x4 proj : register(c4);
float4x4 view : register(c0);
float4x4 viewInverseMatrix : register(c12);

struct VS_IN
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 normal : NORMAL;
	float4 tangent : TANGENT;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord4 : TEXCOORD4;
	float4 texcoord5 : TEXCOORD5;
	float4 texcoord6 : TEXCOORD6;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float3 texcoord5 : TEXCOORD5;
	float3 texcoord6 : TEXCOORD6;
	float4 texcoord8 : TEXCOORD8;
	float4 texcoord7 : TEXCOORD7;
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
	float3 r6;
	r0.x = dot(i.texcoord2, transpose(view)[3]);
	r0.y = dot(i.texcoord3, transpose(view)[3]);
	r0.z = dot(i.texcoord4, transpose(view)[3]);
	r0.w = dot(i.texcoord5, transpose(view)[3]);
	r1 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r0.w = dot(r1, r0);
	r2.w = dot(i.texcoord5, transpose(view)[0]);
	r2.x = dot(i.texcoord2, transpose(view)[0]);
	r2.y = dot(i.texcoord3, transpose(view)[0]);
	r2.z = dot(i.texcoord4, transpose(view)[0]);
	r0.x = dot(r1, r2);
	r3.w = dot(i.texcoord5, transpose(view)[1]);
	r3.x = dot(i.texcoord2, transpose(view)[1]);
	r3.y = dot(i.texcoord3, transpose(view)[1]);
	r3.z = dot(i.texcoord4, transpose(view)[1]);
	r0.y = dot(r1, r3);
	r4.w = dot(i.texcoord5, transpose(view)[2]);
	r4.x = dot(i.texcoord2, transpose(view)[2]);
	r4.y = dot(i.texcoord3, transpose(view)[2]);
	r4.z = dot(i.texcoord4, transpose(view)[2]);
	r0.z = dot(r1, r4);
	o.position.x = dot(r0, transpose(proj)[0]);
	o.position.y = dot(r0, transpose(proj)[1]);
	o.position.z = dot(r0, transpose(proj)[2]);
	o.position.w = dot(r0, transpose(proj)[3]);
	o.texcoord1 = r0.xyz;
	r0 = i.texcoord6;
	r0.xy = i.texcoord1.xy * r0.xy + r0.zw;
	r0.xy = r0.xy + -i.texcoord.xy;
	r1.xyz = float3(1, 0, -1);
	r0.z = r1.z + g_normalmapRate_vs.w;
	o.texcoord.zw = r0.zz * r0.xy + i.texcoord.xy;
	r0.yz = g_normalmapRate_vs.yz;
	o.texcoord8.zw = i.texcoord.xy * r0.yz + g_All_Offset_vs.xy;
	o.texcoord3.x = dot(i.normal.xyz, r2.xyz);
	o.texcoord3.y = dot(i.normal.xyz, r3.xyz);
	o.texcoord3.z = dot(i.normal.xyz, r4.xyz);
	r0 = i.tangent * 2 + -1;
	r0.xyz = r0.www * r0.xyz;
	o.texcoord2.x = dot(r0.xyz, r2.xyz);
	o.texcoord2.y = dot(r0.xyz, r3.xyz);
	o.texcoord2.z = dot(r0.xyz, r4.xyz);
	r2 = i.texcoord3;
	r3.xyz = r2.xyz * i.position.yyy;
	r4 = i.texcoord2;
	r3.xyz = i.position.xxx * r4.xyz + r3.xyz;
	r5 = i.texcoord4;
	r3.xyz = i.position.zzz * r5.xyz + r3.xyz;
	r6.xyz = i.texcoord5.xyz;
	r3.xyz = i.position.www * r6.xyz + r3.xyz;
	r6.x = -transpose(viewInverseMatrix)[0].w;
	r6.y = -transpose(viewInverseMatrix)[1].w;
	r6.z = -transpose(viewInverseMatrix)[2].w;
	o.texcoord6 = r3.xyz + r6.xyz;
	r3 = r0.y * i.texcoord3;
	r3 = r0.x * i.texcoord2 + r3;
	r0 = r0.z * i.texcoord4 + r3;
	r0.w = dot(r0, r0);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord4 = r0.www * r0.xyz;
	r0 = r2 * i.normal.y;
	r0 = i.normal.x * r4 + r0;
	r0 = i.normal.z * r5 + r0;
	r0.w = dot(r0, r0);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord5 = r0.www * r0.xyz;
	o.texcoord3.w = r0.y * g_SkyHemisphereColor.w;
	r0 = float4(-1, -1, -1, -0) + i.color;
	o.color = g_ambientRate.w * r0 + r1.xxxy;
	o.texcoord.xy = i.texcoord.xy;
	o.texcoord2.w = i.tangent.w * 2 + -1;
	o.texcoord8.xy = 0;
	o.texcoord7 = float4(0, 0, 0, 1);

	return o;
}
