float4x4 Rmodelview;
float4 g_BlurParam;
float4x4 g_OldViewProjection;
float4x4 proj;
float4x4 worldMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 normal : NORMAL;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord3 : TEXCOORD3;
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord7 : TEXCOORD7;
	float2 texcoord8 : TEXCOORD8;
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
	o.texcoord8 = r0.xy * g_BlurParam.zz + r2.xy;
	o.texcoord3.x = dot(i.normal.xyz, transpose(Rmodelview)[0].xyz);
	o.texcoord3.y = dot(i.normal.xyz, transpose(Rmodelview)[1].xyz);
	o.texcoord3.z = dot(i.normal.xyz, transpose(Rmodelview)[2].xyz);
	o.position.xyw = r2.xyw;
	o.texcoord7.xyw = r2.xyw;
	o.texcoord3.w = g_BlurParam.w;
	o.texcoord1 = i.texcoord.xy;

	return o;
}
