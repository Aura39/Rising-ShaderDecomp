float4 g_BlurParam : register(c184);
float4x4 g_OldViewProjection : register(c36);
float4x4 proj : register(c4);
float4x4 view : register(c0);

struct VS_IN
{
	float4 position : POSITION;
	float4 normal : NORMAL;
	float4 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord4 : TEXCOORD4;
	float4 texcoord5 : TEXCOORD5;
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
	o.texcoord3.x = dot(i.normal.xyz, r2.xyz);
	r2.w = dot(i.texcoord5, transpose(view)[1]);
	r2.x = dot(i.texcoord2, transpose(view)[1]);
	r2.y = dot(i.texcoord3, transpose(view)[1]);
	r2.z = dot(i.texcoord4, transpose(view)[1]);
	r0.y = dot(r1, r2);
	o.texcoord3.y = dot(i.normal.xyz, r2.xyz);
	r2.w = dot(i.texcoord5, transpose(view)[2]);
	r2.x = dot(i.texcoord2, transpose(view)[2]);
	r2.y = dot(i.texcoord3, transpose(view)[2]);
	r2.z = dot(i.texcoord4, transpose(view)[2]);
	r0.z = dot(r1, r2);
	o.texcoord3.z = dot(i.normal.xyz, r2.xyz);
	o.position.z = dot(r0, transpose(proj)[2]);
	r1 = i.texcoord3;
	r1 = r1 * i.position.y;
	r2 = i.texcoord2;
	r1 = i.position.x * r2 + r1;
	r2 = i.texcoord4;
	r1 = i.position.z * r2 + r1;
	r1 = r1 + i.texcoord5;
	o.texcoord7.z = dot(r1, transpose(g_OldViewProjection)[3]);
	r2.x = dot(r1, transpose(g_OldViewProjection)[0]);
	r2.y = dot(r1, transpose(g_OldViewProjection)[1]);
	r1.x = dot(r0, transpose(proj)[0]);
	r1.y = dot(r0, transpose(proj)[1]);
	r1.w = dot(r0, transpose(proj)[3]);
	r0.xy = -r1.xy + r2.xy;
	o.texcoord8 = r0.xy * g_BlurParam.zz + r1.xy;
	o.position.xyw = r1.xyw;
	o.texcoord7.xyw = r1.xyw;
	o.texcoord3.w = g_BlurParam.w;
	o.texcoord1 = i.texcoord.xy;

	return o;
}
