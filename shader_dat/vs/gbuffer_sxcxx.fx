float4x4 Rmodelview;
float4 g_All_Offset_vs;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float4 g_normalmapRate_vs;
float4x4 proj;
float4x4 viewInverseMatrix;
float4x4 worldMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 normal : NORMAL;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord8 : TEXCOORD8;
	float4 texcoord7 : TEXCOORD7;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
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
	r1.y = dot(i.normal.xyz, transpose(worldMatrix)[1].xyz);
	o.texcoord3.w = r1.y * g_SkyHemisphereColor.w;
	r2 = float4(-1, -1, -1, -0) + i.color;
	o.color = g_ambientRate.w * r2 + r0.xxxy;
	o.texcoord.xy = i.texcoord.xy;
	r1.w = dot(i.normal.xyz, transpose(worldMatrix)[3].xyz);
	r1.x = dot(i.normal.xyz, transpose(worldMatrix)[0].xyz);
	r1.z = dot(i.normal.xyz, transpose(worldMatrix)[2].xyz);
	r0.x = dot(r1, r1);
	r0.x = 1 / sqrt(r0.x);
	r0.xyz = r0.xxx * r1.xyz;
	r1.x = dot(i.position, transpose(worldMatrix)[0]);
	r1.y = dot(i.position, transpose(worldMatrix)[1]);
	r1.z = dot(i.position, transpose(worldMatrix)[2]);
	r2.x = -transpose(viewInverseMatrix)[0].w;
	r2.y = -transpose(viewInverseMatrix)[1].w;
	r2.z = -transpose(viewInverseMatrix)[2].w;
	r1.xyz = r1.xyz + r2.xyz;
	r0.w = dot(r1.xyz, r0.xyz);
	r0.w = r0.w + r0.w;
	r0.xyz = r0.xyz * -r0.www + r1.xyz;
	r0.w = -r0.z;
	o.texcoord4 = r0.xyw;
	o.texcoord8.xy = 0;
	o.texcoord7 = float4(0, 0, 0, 1);

	return o;
}
