sampler A_Occ_sampler;
sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
sampler Spec_Pow_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
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
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float2 r4;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r0.y = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.y = 1 / sqrt(r0.y);
	r0.yzw = -i.texcoord1.xyz * r0.yyy + lightpos.xyz;
	r1.xyz = normalize(r0.yzw);
	r0.y = dot(r1.xyz, i.texcoord3.xyz);
	r0.z = -r0.y + 1;
	r1.x = r0.z * -specularParam.z + r0.y;
	r1.y = specularParam.y;
	r1 = tex2D(Spec_Pow_sampler, r1);
	r0.yzw = r1.xyz * light_Color.xyz;
	r1 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r2 = tex2D(Color_1_sampler, r1.zwzw);
	r1 = tex2D(A_Occ_sampler, r1);
	r0.yzw = r0.yzw * r2.www;
	r0.yzw = r0.xxx * r0.yzw;
	r3.xyz = ambient_rate.xyz;
	r3.xyz = r0.xxx * ambient_rate_rate.xyz + r3.xyz;
	r4.xy = -r1.yy + r1.xz;
	r0.x = max(abs(r4.x), abs(r4.y));
	r0.x = r0.x + -0.015625;
	r1.w = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r1.w;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r1.xz = (r0.xx >= 0) ? r1.yy : r1.xz;
	r0.xyz = r0.yzw * r1.xyz;
	r1.xyz = r1.xyz * r3.xyz + i.texcoord2.xyz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r3.xy = -r2.yy + r2.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r2.xz = (r0.ww >= 0) ? r2.yy : r2.xz;
	r0.w = 1 / ambient_rate.w;
	r3.xyz = r2.xyz * r0.www + specularParam.www;
	r2.xyz = r0.www * r2.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r0.xyz = r2.xyz * r1.xyz + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
