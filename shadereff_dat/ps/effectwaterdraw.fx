float4 g_CameraParam;
float4 g_MatrialColor;
float4 g_Rate;
float4 g_Reflectance;
sampler g_Sampler0;
sampler g_Sampler1;
samplerCUBE g_Sampler2;
sampler g_Sampler3;
float4x4 g_WorldMatrix_pix;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler1, i.texcoord);
	r0.zw = r0.xy + -0.5;
	r0.xy = r0.xy + g_Rate.zw;
	r0.zw = r0.zw * g_Reflectance.xx;
	r1.xy = r0.zw + r0.zw;
	r0.z = dot(r1.z, -r1.z) + 1;
	r0.z = 1 / sqrt(r0.z);
	r1.z = 1 / r0.z;
	r2.xyz = normalize(r1.xyz);
	r1.x = dot(r2.xyz, transpose(g_WorldMatrix_pix)[0].xyz);
	r1.y = dot(r2.xyz, transpose(g_WorldMatrix_pix)[1].xyz);
	r1.z = dot(r2.xyz, transpose(g_WorldMatrix_pix)[2].xyz);
	r2.xyz = normalize(r1.xyz);
	r1.xyz = normalize(i.texcoord1.xyz);
	r0.z = dot(r1.xyz, r2.xyz);
	r0.z = r0.z + r0.z;
	r1.xyz = r2.xyz * -r0.zzz + r1.xyz;
	r1 = tex2D(g_Sampler2, r1);
	r1.xyz = r1.xyz * g_Reflectance.yyy;
	r0.z = 1 / i.texcoord2.w;
	r0.zw = r0.zz * i.texcoord2.xy;
	r0.zw = r0.zw * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy * g_Rate.xy + r0.zw;
	r2 = tex2D(g_Sampler3, r0);
	r1.w = r2.x * g_CameraParam.y + g_CameraParam.x;
	r1.w = r1.w + -i.texcoord3.w;
	r1.w = -r1.w + 1;
	r1.w = -r1.w + r2.x;
	r0.xy = (r1.ww >= 0) ? r0.xy : r0.zw;
	r0 = tex2D(g_Sampler0, r0);
	o.xyz = r0.xyz * g_MatrialColor.xyz + r1.xyz;
	o.w = g_MatrialColor.w;

	return o;
}
