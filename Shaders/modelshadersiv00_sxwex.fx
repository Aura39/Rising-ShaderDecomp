sampler A_Occ_sampler;
sampler Color_1_sampler;
float4 CubeParam;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
samplerCUBE cubemap_sampler;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 light_Color;
float4 lightpos;
float4 prefogcolor_enhance;
float4 specularParam;

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float3 r4;
	float4 r5;
	r0 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r1 = tex2D(A_Occ_sampler, r0);
	r0 = tex2D(Color_1_sampler, r0.zwzw);
	r2.xy = -r1.yy + r1.xz;
	r1.w = max(abs(r2.x), abs(r2.y));
	r1.w = r1.w + -0.015625;
	r2.x = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r2.x;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r1.xz = (r1.ww >= 0) ? r1.yy : r1.xz;
	r2 = tex2D(cubemap_sampler, i.texcoord4);
	r2.xyz = r1.xyz * r2.xyz;
	r2 = r2 * ambient_rate_rate.w;
	r1.w = r2.w * CubeParam.y + CubeParam.x;
	r2.xyz = r0.www * r2.xyz;
	r2.xyz = r1.www * r2.xyz;
	r3.xy = -r0.yy + r0.xz;
	r1.w = max(abs(r3.x), abs(r3.y));
	r1.w = r1.w + -0.015625;
	r2.w = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r2.w;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r0.xz = (r1.ww >= 0) ? r0.yy : r0.xz;
	r1.w = 1 / ambient_rate.w;
	r3.xyz = r0.xyz * r1.www;
	r0.xyz = r0.xyz * r1.www + specularParam.www;
	r4.xyz = r2.xyz * r3.xyz;
	r1.w = 1 / i.texcoord7.w;
	r5.xy = r1.ww * i.texcoord7.xy;
	r5.xy = r5.xy * float2(0.5, -0.5) + 0.5;
	r5.xy = r5.xy + g_TargetUvParam.xy;
	r5 = tex2D(Shadow_Tex_sampler, r5);
	r1.w = r5.z + g_ShadowUse.x;
	r5.xyz = ambient_rate_rate.xyz;
	r5.xyz = r1.www * r5.xyz + ambient_rate.xyz;
	r5.xyz = r1.xyz * r5.xyz + i.texcoord2.xyz;
	r3.xyz = r3.xyz * r5.xyz;
	r5.xyz = r4.xyz * CubeParam.zzz + r3.xyz;
	r4.xyz = r4.xyz * CubeParam.zzz;
	r3.xyz = r3.xyz * -r4.xyz + r5.xyz;
	r2.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r2.w = 1 / sqrt(r2.w);
	r4.xyz = -i.texcoord1.xyz * r2.www + lightpos.xyz;
	r5.xyz = normalize(r4.xyz);
	r2.w = dot(r5.xyz, i.texcoord3.xyz);
	r3.w = pow(r2.w, specularParam.z);
	r4.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r4.y = (-r4.x >= 0) ? 0 : 1;
	r4.x = r4.x * r4.y;
	r2.w = (-r2.w >= 0) ? 0 : r4.y;
	r2.w = r3.w * r2.w;
	r4.xyz = r4.xxx * light_Color.xyz;
	r4.xyz = r2.www * r4.xyz;
	r4.xyz = r0.www * r4.xyz;
	r4.xyz = r1.www * r4.xyz;
	r1.xyz = r1.xyz * r4.xyz;
	r0.w = abs(specularParam.x);
	r1.xyz = r0.www * r1.xyz;
	r0.xyz = r1.xyz * r0.xyz + r3.xyz;
	r1.y = 1;
	r0.w = r1.y + -CubeParam.z;
	r0.xyz = r2.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}