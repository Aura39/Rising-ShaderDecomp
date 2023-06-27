float4x4 Rmodelview;
float4 g_BlurParam;
float4x4 g_OldViewProjection;
float4x4 proj;
float4x4 worldMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float2 r2;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.x = dot(r0, transpose(worldMatrix)[0]);
	r1.y = dot(r0, transpose(worldMatrix)[1]);
	r1.z = dot(r0, transpose(worldMatrix)[2]);
	r1.w = dot(r0, transpose(worldMatrix)[3]);
	o.texcoord8.z = dot(r1, transpose(g_OldViewProjection)[2]);
	o.texcoord8.w = dot(r1, transpose(g_OldViewProjection)[3]);
	r2.x = dot(r1, transpose(g_OldViewProjection)[0]);
	r2.y = dot(r1, transpose(g_OldViewProjection)[1]);
	r1.x = dot(r0, transpose(Rmodelview)[0]);
	r1.y = dot(r0, transpose(Rmodelview)[1]);
	r1.z = dot(r0, transpose(Rmodelview)[2]);
	r1.w = dot(r0, transpose(Rmodelview)[3]);
	r0.x = dot(r1, transpose(proj)[0]);
	r0.y = dot(r1, transpose(proj)[1]);
	r2.xy = -r0.xy + r2.xy;
	o.texcoord8.xy = r2.xy * g_BlurParam.zz + r0.xy;
	r0.z = dot(r1, transpose(proj)[2]);
	r0.w = dot(r1, transpose(proj)[3]);
	o.position = r0;
	o.texcoord7 = r0;
	o.texcoord = float4(1, 1, 0, 0) * i.texcoord.xyxx;

	return o;
}
