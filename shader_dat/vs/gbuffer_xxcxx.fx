float4x4 Rmodelview : register(c20);
float4 g_All_Offset_vs : register(c185);
float4 g_SkyHemisphereColor : register(c189);
float4 g_ambientRate : register(c191);
float4 g_normalmapRate_vs : register(c186);
float4x4 proj : register(c4);
float4x4 viewInverseMatrix : register(c12);
float4x4 worldMatrix : register(c16);

struct VS_IN
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 normal : NORMAL;
	float4 tangent : TANGENT;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
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
	float3 r3;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.w = dot(r0, transpose(Rmodelview)[3]);
	r1.x = dot(r0, transpose(Rmodelview)[0]);
	r1.y = dot(r0, transpose(Rmodelview)[1]);
	r1.z = dot(r0, transpose(Rmodelview)[2]);
	o.position.x = dot(r1, transpose(proj)[0]);
	o.position.y = dot(r1, transpose(proj)[1]);
	o.position.z = dot(r1, transpose(proj)[2]);
	o.position.w = dot(r1, transpose(proj)[3]);
	o.texcoord1 = r1.xyz;
	r0.xyz = float3(1, 0, -1);
	r0.z = r0.z + g_normalmapRate_vs.w;
	r1.xy = i.texcoord.xy;
	r1.zw = -r1.xy + i.texcoord1.xy;
	o.texcoord.zw = r0.zz * r1.zw + i.texcoord.xy;
	r2.yz = g_normalmapRate_vs.yz;
	o.texcoord8.zw = r1.xy * r2.yz + g_All_Offset_vs.xy;
	o.texcoord3.x = dot(i.normal.xyz, transpose(Rmodelview)[0].xyz);
	o.texcoord3.y = dot(i.normal.xyz, transpose(Rmodelview)[1].xyz);
	o.texcoord3.z = dot(i.normal.xyz, transpose(Rmodelview)[2].xyz);
	r1 = i.tangent * 2 + -1;
	r1.xyz = r1.www * r1.xyz;
	o.texcoord2.x = dot(r1.xyz, transpose(Rmodelview)[0].xyz);
	o.texcoord2.y = dot(r1.xyz, transpose(Rmodelview)[1].xyz);
	o.texcoord2.z = dot(r1.xyz, transpose(Rmodelview)[2].xyz);
	r2.x = dot(i.position, transpose(worldMatrix)[0]);
	r2.y = dot(i.position, transpose(worldMatrix)[1]);
	r2.z = dot(i.position, transpose(worldMatrix)[2]);
	r3.x = -transpose(viewInverseMatrix)[0].w;
	r3.y = -transpose(viewInverseMatrix)[1].w;
	r3.z = -transpose(viewInverseMatrix)[2].w;
	o.texcoord6 = r2.xyz + r3.xyz;
	r2.w = dot(r1.xyz, transpose(worldMatrix)[3].xyz);
	r2.x = dot(r1.xyz, transpose(worldMatrix)[0].xyz);
	r2.y = dot(r1.xyz, transpose(worldMatrix)[1].xyz);
	r2.z = dot(r1.xyz, transpose(worldMatrix)[2].xyz);
	r0.z = dot(r2, r2);
	r0.z = 1 / sqrt(r0.z);
	o.texcoord4 = r0.zzz * r2.xyz;
	r1.w = dot(i.normal.xyz, transpose(worldMatrix)[3].xyz);
	r1.x = dot(i.normal.xyz, transpose(worldMatrix)[0].xyz);
	r1.z = dot(i.normal.xyz, transpose(worldMatrix)[2].xyz);
	r1.y = dot(i.normal.xyz, transpose(worldMatrix)[1].xyz);
	r0.z = dot(r1, r1);
	r0.z = 1 / sqrt(r0.z);
	o.texcoord5 = r0.zzz * r1.xyz;
	o.texcoord3.w = r1.y * g_SkyHemisphereColor.w;
	r1 = float4(-1, -1, -1, -0) + i.color;
	o.color = g_ambientRate.w * r1 + r0.xxxy;
	o.texcoord.xy = i.texcoord.xy;
	o.texcoord2.w = i.tangent.w * 2 + -1;
	o.texcoord8.xy = 0;
	o.texcoord7 = float4(0, 0, 0, 1);

	return o;
}
