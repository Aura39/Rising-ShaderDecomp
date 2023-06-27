float4x4 Rmodelview;
float4 g_All_Offset;
float4 g_BlurParam;
float4x4 g_OldViewProjection;
float4x4 proj;
float4x4 viewInverseMatrix;
float4x4 worldMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 normal : NORMAL;
	float4 tangent : TANGENT;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float3 texcoord5 : TEXCOORD5;
	float3 texcoord6 : TEXCOORD6;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
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
	o.texcoord1 = r1.xyz;
	r0.xy = r0.xy + -r2.xy;
	o.texcoord8.xy = r0.xy * g_BlurParam.zz + r2.xy;
	o.texcoord8.zw = g_All_Offset.xy + i.texcoord.xy;
	o.texcoord3.x = dot(i.normal.xyz, transpose(Rmodelview)[0].xyz);
	o.texcoord3.y = dot(i.normal.xyz, transpose(Rmodelview)[1].xyz);
	o.texcoord3.z = dot(i.normal.xyz, transpose(Rmodelview)[2].xyz);
	r0 = i.tangent * 2 + -1;
	r0.xyz = r0.www * r0.xyz;
	o.texcoord2.x = dot(r0.xyz, transpose(Rmodelview)[0].xyz);
	o.texcoord2.y = dot(r0.xyz, transpose(Rmodelview)[1].xyz);
	o.texcoord2.z = dot(r0.xyz, transpose(Rmodelview)[2].xyz);
	r1.x = dot(i.position, transpose(worldMatrix)[0]);
	r1.y = dot(i.position, transpose(worldMatrix)[1]);
	r1.z = dot(i.position, transpose(worldMatrix)[2]);
	r3.x = -transpose(viewInverseMatrix)[0].w;
	r3.y = -transpose(viewInverseMatrix)[1].w;
	r3.z = -transpose(viewInverseMatrix)[2].w;
	o.texcoord6 = r1.xyz + r3.xyz;
	r1.w = dot(r0.xyz, transpose(worldMatrix)[3].xyz);
	r1.x = dot(r0.xyz, transpose(worldMatrix)[0].xyz);
	r1.y = dot(r0.xyz, transpose(worldMatrix)[1].xyz);
	r1.z = dot(r0.xyz, transpose(worldMatrix)[2].xyz);
	r0.x = dot(r1, r1);
	r0.x = 1 / sqrt(r0.x);
	o.texcoord4 = r0.xxx * r1.xyz;
	r0.w = dot(i.normal.xyz, transpose(worldMatrix)[3].xyz);
	r0.x = dot(i.normal.xyz, transpose(worldMatrix)[0].xyz);
	r0.y = dot(i.normal.xyz, transpose(worldMatrix)[1].xyz);
	r0.z = dot(i.normal.xyz, transpose(worldMatrix)[2].xyz);
	r0.w = dot(r0, r0);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord5 = r0.www * r0.xyz;
	o.position.xyw = r2.xyw;
	o.texcoord7.xyw = r2.xyw;
	o.texcoord.xy = i.texcoord.xy;
	o.texcoord.zw = i.texcoord1.xy;
	o.texcoord2.w = i.tangent.w * 2 + -1;

	return o;
}
