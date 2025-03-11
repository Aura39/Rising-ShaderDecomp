float4x4 Rmodelview : register(c20);
float4 g_All_Offset_vs : register(c185);
float4 g_BlurParam : register(c184);
float4x4 g_OldViewProjection : register(c36);
float4 g_ambientRate : register(c191);
float4 g_normalmapRate_vs : register(c186);
float4x4 proj : register(c4);
float4x4 worldMatrix : register(c16);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float3 texcoord9 : TEXCOORD9;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.x = dot(r0, transpose(Rmodelview)[0]);
	r1.y = dot(r0, transpose(Rmodelview)[1]);
	r1.z = dot(r0, transpose(Rmodelview)[2]);
	r1.w = dot(r0, transpose(Rmodelview)[3]);
	o.position.z = dot(r1, transpose(proj)[2]);
	r2.x = dot(r0, transpose(worldMatrix)[0]);
	r2.y = dot(r0, transpose(worldMatrix)[1]);
	r2.z = dot(r0, transpose(worldMatrix)[2]);
	r2.w = dot(r0, transpose(worldMatrix)[3]);
	o.texcoord7.z = dot(r2, transpose(g_OldViewProjection)[3]);
	r0.x = dot(r2, transpose(g_OldViewProjection)[0]);
	r0.y = dot(r2, transpose(g_OldViewProjection)[1]);
	r2.x = dot(r1, transpose(proj)[0]);
	r2.y = dot(r1, transpose(proj)[1]);
	r2.w = dot(r1, transpose(proj)[3]);
	r0.xy = r0.xy + -r2.xy;
	o.texcoord8.xy = r0.xy * g_BlurParam.zz + r2.xy;
	r0.z = -1;
	r0.x = r0.z + g_normalmapRate_vs.w;
	r0.yz = i.texcoord1.xy;
	r1.xy = i.texcoord.xy;
	r0.yz = r0.yz + -r1.xy;
	o.texcoord.zw = r0.xx * r0.yz + r1.xy;
	r0.yz = g_normalmapRate_vs.yz;
	o.texcoord8.zw = i.texcoord.xy * r0.yz + g_All_Offset_vs.xy;
	o.position.xyw = r2.xyw;
	o.texcoord7.xyw = r2.xyw;
	o.texcoord.xy = i.texcoord.xy;
	o.texcoord9 = g_ambientRate.xyz;

	return o;
}
